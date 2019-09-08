;;; livemd.el --- Realtime Markdown previews for FG42.

;; Copyright (C) 2014-2016 Hrvoje Simic
;; Copyright (C) 2019      Sameer Rahmani <lxsameer@gnu.org>

;; Author: Hrvoje Simic <hrvoje@twobucks.co>
;; Version: 1.0.0
;; Keywords: markdown, preview, live
;; URL: https://gitlab.com/FG42/FG42

;; This is a clone of https://github.com/shime/emacs-livedown
;; Kudos to Hrvoje Simic for his great work.

;;; Commentary:
;; Realtime Markdown previews for Emacs.
;;; Code:

(defgroup livemd nil
  "Realtime Markdown previews"
  :group 'livemd
  :prefix "livemd-")

(defcustom livedown-path "livedown"
  "Path to livedown executable."
  :type 'string
  :group 'livemd)

(defcustom livemd-port 1337
  "Port on which livemd server will run."
  :type 'integer
  :group 'livemd)

(defcustom livemd-open t
  "Open browser automatically."
  :type 'boolean
  :group 'livemd)

(defcustom livemd-browser nil
  "Open alternative browser."
  :type 'string
  :group 'livemd)

(defcustom livemd-autostart nil
  "Auto-open previews when opening markdown files."
  :type 'boolean
  :group 'livemd)

;;;###autoload
(defun livemd-preview ()
  "Preview the current file in livemd."
  (interactive)

  (call-process-shell-command (format "livedown stop --port %s &" livemd-port))

  (message (format "%s start %s --port %s %s %s "
                   livedown-path
                   buffer-file-name
                   livemd-port
                   (if livemd-browser (concat "--browser " livemd-browser) "")
                   (if livemd-open "--open" "")))
  (start-process-shell-command
   "livedown"
   "*fg42-livemd-buffer*"
   (format "%s start %s --port %s %s %s "
           livedown-path
           buffer-file-name
           livemd-port
           (if livemd-browser (concat "--browser " livemd-browser) "")
           (if livemd-open "--open" ""))))

;;  (print (format "%s rendered @ %s" buffer-file-name livemd-port) (get-buffer "emacs-livemd-buffer")))
;;;###autoload
(defun livemd-kill (&optional async)
  "Stop the livemd process ASYNC or otherwise."
  (interactive)
  (let ((stop-livemd (if async 'async-shell-command 'call-process-shell-command)))
    (funcall stop-livemd (format "%s stop --port %s &" livedown-path livemd-port))))

(if livemd-autostart
  (eval-after-load 'markdown-mode '(livemd-preview)))

(add-hook 'kill-emacs-query-functions (lambda () (livemd-kill t)))


(provide 'extensions/development/livemd)
;;; livemd.el ends here
