;;; lxmode-line --- A small utility library to toggle the modeline.
;;; Commentary:
;;; Code:
(defvar hidden-modeline nil)

(defun hide-modeline ()
  "Hide the mode-line."
  (interactive)
  (message "Hidding mode-line...")
  (setq hidden-modeline mode-line-format)
  (setq mode-line-format nil))

(defun show-modeline ()
  "Show the mode-line."
  (interactive)
  (message "Showing mode-line...")
  (setq mode-line-format hidden-modeline)
  (setq hidden-modeline nil))


(defun toggle-modeline ()
  "Toggle the modeline."
  (interactive)
  (if (not hidden-modeline)
      (hide-modeline)
      (show-modeline)))


(ability togglable-modeline ()
         "Togglable modeline"
         (global-set-key (kbd "<f6>") 'toggle-modeline))

(provide 'extensions/editor/lxmodeline)
;;; lxmodeline ends here
