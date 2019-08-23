;;; fg42-devtools --- Webkit devtool driver for FG42
;;
;; Copyright (c) 2019  Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Keywords: webkit
;; Version: 0.1.0
;; Package-Requires: ((dash "2.11.0") (websocket "1.5"))
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Acknoledgement:
;; This library is heavily inspired by Kite mini library. Kudos Tung Dao
;; for his great work.
;;
;;; Commentary:
;;; Code:


(require 'url)
(require 'dash)
(require 'websocket)

(require 'fg42/utils)

;;; Customs & Vars ------------------------------------------------------------
(defcustom fg42/devtools-remote-host "127.0.0.1"
  "Default host for connection to WebKit remote debugging API."
  :group 'fg42/devtools)


(defcustom fg42/devtools-remote-port 9222
  "Default port for connection to WebKit remote debugging API."
  :group 'fg42/devtools)


(defvar fg42/devtools-socket nil
  "Websocket connection to WebKit remote debugging API.")


(defvar fg42/devtools-rpc-id 0)
(defvar fg42/devtools-rpc-callbacks nil)
(defvar fg42/devtools-rpc-scripts nil
  "List of JavaScript files available for live editing.")

;;; Functions -----------------------------------------------------------------
(defun fg42/devtools-next-rpc-id ()
  "Retun the next RPC call id to be used."
  (setq fg42/devtools-rpc-id (+ 1 fg42/devtools-rpc-id)))


(defun fg42/devtools-register-callback (id fn)
  "Register the given FN function with the given ID as rpc Callback."
  (let ((hook (intern (number-to-string id) fg42/devtools-rpc-callbacks)))
    (add-hook hook fn t)))

(defun fg42/devtools-dispatch-callback (id data)
  "Execute the callback registered by the given ID with the given DATA."
  (let ((hook (intern (number-to-string id) fg42/devtools-rpc-callbacks)))
    (when hook
      (run-hook-with-args hook data)
      (unintern hook fg42/devtools-rpc-callbacks))))


(defun fg42/devtools-on-open (socket)
  "Connect to the given SOCKET."
  (message "FG42: connected to devtools."))


(defun fg42/devtools-on-close (socket)
  "Disconnect from the given SOCKET."
  (message "FG42: disconnected from devtools."))


(defun fg42/devtools-on-script-parsed (data)
  (let ((extension? (plist-get data :isContentScript))
        (url (plist-get data :url))
        (id (plist-get data :scriptId)))
    (when (and (eq extension? :json-false) (not (string-equal "" url)))
      (add-to-list 'fg42/devtools-rpc-scripts (list :id id :url url)))))


(defun fg42/devtools-on-script-failed-to-parse (data)
  (fg42/devtools-console-append (format "%s" data)))


(defun fg42/devtools-on-message-added (data)
  (let* ((message (plist-get data :message))
         (url (plist-get message :url))
         (column (plist-get message :column))
         (line (plist-get message :line))
         (type (plist-get message :type))
         (level (plist-get message :level))
         (text (plist-get message :text)))
    ;; TODO: add colors based on level
    (fg42/devtools-console-append
     (propertize
      (format "%s: %s\t%s (line: %s column: %s)"
              level text url line column)
      'font-lock-face (intern (format "fg42/devtools-log-%s" level))))))


(defun fg42/devtools-on-message (socket data)
  "The on message callback that gets the incoming DATA from the SOCKET."
  (let* ((data (<-json (websocket-frame-payload data)))
         (method (plist-get data :method))
         (params (plist-get data :params)))
    (inspect-data-append data)
    (pcase method
      ("Debugger.scriptParsed" (fg42/devtools-on-script-parsed params))
      ;; we are getting an error in Console.messageAdded
      ;; ("Debugger.scriptFailedToParse" (fg42/devtools-on-script-failed-to-parse params))
      ("Console.messageAdded" (fg42/devtools-on-message-added params))
      ;; ;; TODO: do something usefull here, possibly great for REPL
      ("Console.messageRepeatCountUpdated")
      ;; nil -> These are return messages from RPC calls, not notification
      (_ (if method
             (inspect-data-append data)
           (fg42/devtools-dispatch-callback (plist-get data :id)
                                            (plist-get data :result)))))))


(defun fg42/devtools-call-rpc (method &optional params callback)
  "Call the given METHOD with PARAMS and call CALLBACK with the result."
  (let ((id (fg42/devtools-next-rpc-id)))
    (when callback
      (fg42/devtools-register-callback id callback))
    (websocket-send-text
     fg42/devtools-socket
     (->json (list :id id
                   :method method
                   :params params)))))


(defun fg42/devtools-open-socket (url)
  "Connect to the given URL and return a socket."
  (websocket-open url
                  :on-open #'fg42/devtools-on-open
                  :on-message #'fg42/devtools-on-message
                  :on-close #'fg42/devtools-on-close))


(defun fg42/devtools-get-json (url)
  "Fetch the json data of the given URL using a GET request."
  (let* ((url-request-method "GET")
         (url-http-attempt-keepalives nil)
         (json-array-type 'list)
         (json-object-type 'plist))
    (with-current-buffer (url-retrieve-synchronously url)
      (if (not (eq 200 (url-http-parse-response)))
          (error "FG42: Unable to connect to devtools host")
        (goto-char (+ 1 url-http-end-of-headers))
        (json-read)))))


(defun fg42/devtools-get-tabs (host port)
  "Read the list of open tabs from the webkit instance at HOST:PORT."
  (let* ((url (url-parse-make-urlobj
               "http" nil nil host port "/json"))
         (tabs (fg42/devtools-get-json url)))
    (-filter (lambda (tab)
               (and (plist-get tab :webSocketDebuggerUrl)
                    (string-equal (plist-get tab :type) "page")))
             tabs)))


(defun fg42/devtools-tab-completion (tab)
  "A simple completion backend for the given TAB."
  (let ((title (plist-get tab :title))
        (url (plist-get tab :url)))
    (cons (format "%s" title) tab)))


(defun fg42/devtools-select-tab (host port)
  "Print out the list of tabs from HOST:PORT for the user to choose from."
  (let* ((tabs (mapcar #'fg42/devtools-tab-completion
                       (fg42/devtools-get-tabs host port)))
         (selection (completing-read
                     "Tab: " tabs nil t "" nil (caar tabs)))
         (tab (cdr (assoc selection tabs))))
    (plist-get tab :webSocketDebuggerUrl)))


(defun fg42/devtools-connect ()
  "Conntect to the Webkit devtools."
  (interactive)
  (message "FG42: Disconnect from any previous connection.")
  (fg42/devtools-disconnect)
  (let* ((socket-url (fg42/devtools-select-tab fg42/devtools-remote-host
                                               fg42/devtools-remote-port)))
    (message (format "FG42: Connecting to %s" socket-url))
    (setq fg42/devtools-socket (fg42/devtools-open-socket socket-url))
    (message "Sending initial RPC calls...")
    (fg42/devtools-call-rpc "Console.enable")
    (fg42/devtools-call-rpc "Debugger.enable")
    (fg42/devtools-call-rpc "Network.setCacheDisabled" '(:cacheDisabled t))))


(defun fg42/devtools-disconnect ()
  "Disconnect from the Webkit devtools."
  (interactive)
  (when (websocket-openp fg42/devtools-socket)
    (websocket-close fg42/devtools-socket)
    (setq fg42/devtools-socket nil
          fg42/devtools-rpc-scripts nil)))


(defun fg42/devtools-send-eval (code &optional callback)
  "Send the given CODE to the devtools for evaluation and call the CALLBACK."
  (fg42/devtools-call-rpc
   "Runtime.evaluate"
   (list :expression code
         :returnByValue t)
   callback))


(defun fg42/devtools-remove-script (script)
  (setq fg42/devtools-rpc-scripts
        (delete script fg42/devtools-rpc-scripts)))


(defun fg42/devtools-script-id (file)
  (let* ((name (file-name-nondirectory file))
         (script (--find (string-suffix-p name (plist-get it :url))
                         fg42/devtools-rpc-scripts)))
    (when script (plist-get script :id))))


(defun fg42/devtools-update ()
  (interactive)
  (let ((id (fg42/devtools-script-id (buffer-file-name)))
        (source (buffer-substring-no-properties
                 (point-min) (point-max))))
    (if id
        (fg42/devtools-call-rpc
         "Debugger.setScriptSource"
         (list :scriptId id :scriptSource source))
      (message "No matching script for current buffer."))))


(defun fg42/devtools-reload ()
  "Reload the tab."
  (interactive)
  (fg42/devtools-call-rpc
   "Page.reload"
   (list :ignoreCache t)))


(defun fg42/devtools-evaluate-region-or-line (&optional args)
  (interactive "*P")
  (let ((start (if (region-active-p)
                   (region-beginning)
                 (line-beginning-position)))
        (end (if (region-active-p)
                 (region-end)
               (line-end-position))))
    (fg42/devtools-send-eval (buffer-substring-no-properties start end))))


(defvar fg42/devtools-mode-map
  (let ((map (make-sparse-keymap)))
    (prog1 map
      (define-key map (kbd "C-c C-c") #'fg42/devtools-evaluate-region-or-line)
      (define-key map (kbd "C-c C-k") #'fg42/devtools-update)
      (define-key map (kbd "C-c C-r") #'fg42/devtools-reload)))
  "Keymap for FG42 devtools mode.")

;;;###autoload
(defun turn-on-fg42/devtools-mode ()
  "Turn on FG42 devtools mode.")

;;;###autoload
(defun turn-off-fg42/devtools-mode ()
  "Turn off FG42 devtools mode.")

;;;###autoload
(define-minor-mode fg42/devtools-mode
  "Minor mode for interact with WebKit remote debugging API."
  :global nil
  :group 'fg42/devtools
  :init-value nil
  :lighter ""
  :keymap fg42/devtools-mode-map
  (if fg42/devtools-mode
      (turn-on-fg42/devtools-mode)
    (turn-off-fg42/devtools-mode)))

(defun fg42/devtools-debug-on ()
  (interactive)
  (setq websocket-callback-debug-on-error t))

(defun fg42/devtools-debug-restart ()
  (interactive)
  (fg42/devtools-debug-on)
  (message "D: disconnect")
  (fg42/devtools-disconnect)
  (fg42/devtools-connect))

;; (fg42/devtools-debug-restart)


(provide 'fg42/devtools)
;;; devtools.el ends here
