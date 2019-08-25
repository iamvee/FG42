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
;; This library is heavily inspired by kite mini library. Kudos Tung Dao
;; for his great work.
;;
;;; Commentary:
;;; Code:
(require 'cl)
(require 'comint)
(require 'fg42/devtools)
;; For syntax highlighting
(require 'js)

;;; Faces for console message -------------------------------------------------
(defface fg42/devtools-log-warning
  '((t :inherit warning))
  "Basic face used to highlight warnings."
  :version "24.1"
  :group 'fg42/devtools-faces)


(defface fg42/devtools-log-error
  '((t :inherit error))
  "Basic face used to highlight errors."
  :version "24.1"
  :group 'fg42/devtools-faces)


(defface fg42/devtools-log-debug
  '((t :inherit font-lock-comment))
  "Basic face used to highlight debug-level messages."
  :version "24.1"
  :group 'fg42/devtools-faces)


(defface fg42/devtools-log-log
  '((t :inherit default))
  "Basic face used to highlight regular messages."
  :version "24.1"
  :group 'fg42/devtools-faces)


;; Customs & Variables --------------------------------------------------------
(defcustom fg42/devtools-console-prompt "JS> "
  "Prompt used in fg42/devtools-console."
  :group 'fg42/devtools)


(defvar fg42/devtools-console-mode-map
  (let ((map (copy-keymap widget-keymap))
        (menu-map (make-sparse-keymap)))
      ;;(suppress-keymap map t)
      (define-key map "\t" 'fg42/devtools-async-completion-at-point)
      (define-key map "\C-cX" 'kite-clear-console)
      (define-key map "\C-cg" 'kite-console-visit-source)
      (define-key map "\C-ci" 'kite-show-log-entry)
      (define-key map "\C-j" 'fg42/devtools-console-send-input)
      (define-key map (kbd "RET") 'fg42/devtools-console-send-input)
      map)
  "Local keymap for `kite-console-mode' buffers.")


(defvar fg42/devtools-console-input)


(defun fg42/devtools-append-to-console-buffer)
(define-derived-mode fg42/devtools-console-mode comint-mode "fg42/devtools-console"
  "Provide a REPL into the visiting browser."
  :group 'fg42/devtools
  :syntax-table emacs-lisp-mode-syntax-table
  (setq comint-prompt-regexp (concat "^" (regexp-quote fg42/devtools-console-prompt))
        comint-get-old-input 'fg42/devtools-console-get-old-input ;; TODO: why?
        comint-input-sender 'fg42/devtools-console-input-sender
        comint-process-echoes nil)
  ;; (set (make-local-variable 'comint-prompt-read-only) t)
  (unless (comint-check-proc (current-buffer))
    (start-process "fg42/devtools-console" (current-buffer) nil)
    (set-process-query-on-exit-flag (fg42/devtools-console-process) nil)

    (set (make-local-variable 'font-lock-defaults)
         (list js--font-lock-keywords))

    (goto-char (point-max))
    (set (make-local-variable 'comint-inhibit-carriage-motion) t)
    (comint-output-filter (fg42/devtools-console-process) fg42/devtools-console-prompt)
    (set-process-filter (fg42/devtools-console-process) 'comint-output-filter)))

(defun fg42/devtools-append-to-console-buffer (log-entry)
  (let* ((message (plist-get data :message))
         (url (plist-get message :url))
         (column (plist-get message :column))
         (line (plist-get message :line))
         (type (plist-get message :type))
         (level (plist-get message :level))
         (text (plist-get message :text)))
    (->buffer
     fg42/devtools-console-buffer-name
     (format "[%s:%s:%s]<%s>: %s"
             (apply-face 'error url)
             line
             column
             level
             message))))


;; (defun fg42/devtools-console-append (data)
;;   (let ((buffer (get-buffer-create fg42/devtools-console-buffer-name)))
;;     (when buffer
;;       (with-current-buffer buffer
;;         (comint-output-filter (fg42/devtools-console-process) (concat data "\n"))))))


(defun fg42/devtools-console-process ()
  ;; Return the current buffer's process.
  (get-buffer-process (current-buffer)))


(defun fg42/devtools-console-get-old-input nil
  ;; Return the previous input surrounding point
  (save-excursion
    (beginning-of-line)
    (unless (looking-at-p comint-prompt-regexp)
      (re-search-backward comint-prompt-regexp))
    (comint-skip-prompt)
    (buffer-substring (point) (progn (forward-sexp 1) (point)))))


(defun fg42/devtools-console-input-sender (_proc input)
  ;; Just sets the variable fg42/devtools-console-input, which is in the scope
  ;; of `fg42/devtools-console-send-input's call.
  (setq fg42/devtools-console-input input))


(defun fg42/devtools-console-send-input ()
  "Evaluate the current console prompt input."
  (interactive)
  (let (fg42/devtools-console-input)           ; set by
                                        ; kite-console-input-sender
    (comint-send-input)      ; update history, markers etc.
    (fg42/devtools-console-eval-input fg42/devtools-console-input)))


(defun fg42/devtools-console-eval-input (input)
  (fg42/devtools-send-eval
   input
   (lambda (result)
     (if (eq :json-false (plist-get result :wasThrown))
         (comint-output-filter
          (fg42/devtools-console-process)
          (format "%s\n%s"
                  (plist-get (plist-get result :result) :value)
                  fg42/devtools-console-prompt))
       ;; TODO: fix and release object?
       (format "Error: %s\n%s"
               result
               fg42/devtools-console-prompt)))))
;; (let ((object-id
;;        (kite--get result :result :objectId)))
;;   (when object-id
;;     (kite--release-object object-id)))

;; (defun fg42/devtools--eval-in-current-context (input success-function)
;;   "Evaluate INPUT in the remote remote debugger in the current
;; execution context and asynchronously invoke SUCCESS-FUNCTION with
;; the results in case of success."
;;   (let ((eval-params (list :expression input))
;;         (context-id (plist-get (kite-session-current-context
;;                                 kite-session)
;;                                :id)))
;;     (when context-id
;;       (setq eval-params (plist-put eval-params :contextId context-id)))
;;     (kite-send
;;      "Runtime.evaluate"
;;      :params
;;      eval-params
;;      :success-function
;;      success-function)))


(defconst fg42/devtools--identifier-part-regexp
  (rx
   word-boundary
   (1+ (or alnum
           ?.
           (: "\\x" (repeat 2 xdigit))
           (: "\\u" (repeat 4 xdigit))))
   point)
  "Used by `kite-async-completion-at-point' to find a part of a
JavaScript identifier.")


(defun fg42/devtools-async-completion-at-point ()
  "Asynchronously fetch completions for the JavaScript expression
at point and, once results have arrived, perform completion using
`completion-in-region'.

Note: we can't use the usual mechanism of hooking into the
completions API (`completion-at-point-functions') because it
doesn't support asynchronicity."
  (interactive)
  (let (completion-begin)

    ;; Find the dotted JavaScript expression (consisting of
    ;; identifiers only) before point.  Note that we can't use just a
    ;; single regex because greedy regexes don't work when searching
    ;; backwards.
    (save-excursion
      (save-match-data
        (while (re-search-backward fg42/devtools--identifier-part-regexp nil t))
        (setq completion-begin (point))))

    ;; FIXME: the previous step is too broad, it will find identifiers
    ;; starting with a digit.  Could do a second pass here to make
    ;; sure that we're looking at a valid expression, or improve error
    ;; handling in `kite--get-properties-fast' to ensure that we do
    ;; the right thing when the JavaScript side gets back to us with a
    ;; complaint.

    (when (< completion-begin (point))
      (let* ((components (split-string (buffer-substring-no-properties
                                        completion-begin
                                        (point))
                                       "\\."))
             (last-component (car (last components))))

        (lexical-let ((lex-completion-begin (- (point)
                                               (length last-component)))
                      (lex-completion-end (point)))
          (fg42/devtools--get-properties-fast
           (if (> (length components) 1)
               (mapconcat 'identity
                          (subseq components
                                  0
                                  (- (length components) 1))
                          ".")
             "window")
           (concat "^" (regexp-quote last-component))
           (lambda (completions)
             (let* (completion-extra-properties
                    completion-in-region-mode-predicate)
               (completion-in-region
                lex-completion-begin
                lex-completion-end
                completions)))))))))


(defun fg42/devtools--get-properties-fast (object-expr js-regex callback)
  "Efficiently and asynchronously fetch matching property names
for the object resulting from evaluating OBJECT-EXPR, a
JavaScript expression.  Only properties matching JS-REGEX, a
regular expression using JavaScript syntax, are fetched.  The
resulting property names are passed as an unsorted list of
strings to CALLBACK, which should accept a single parameter.

FIXME: no error handling."
  (lexical-let ((lex-callback callback))
    (fg42/devtools-send-eval
     (format "(function(val) {
  var regex = new RegExp('%s')
  var test = regex.test.bind(regex)
  var keys = new Set
  for (var key in val) regex.test(key) && keys.add(key)
  Object.getOwnPropertyNames(val).forEach(key => regex.test(key) && keys.add(key))
  return Array.from(keys)
})(%s)"
             js-regex
             object-expr)
     (lambda (result)
       (funcall lex-callback (plist-get (plist-get result :result) :value))))))


(defun fg42/devtools--release-object (object-id)
  "Release the object with the given OBJECT-ID on the browser
side."
  (when (null object-id)
    (error "kite--release-object called with null OBJECT-ID"))
  (fg42/devtools-call-rpc "Runtime.releaseObject"
                      `((objectId . ,object-id))))


(defun fg42/devtools-console ()
  "Start a FG42 devtools console."
  (interactive)
  (when (not (get-buffer "*fg42/devtools-console*"))
    (with-current-buffer (get-buffer-create "*fg42/devtools-console*")
      (fg42/devtools-console-mode)))
  (pop-to-buffer (get-buffer "*fg42/devtools-console*")))


(provide 'fg42/devtools/console)
;; console.el ends here
