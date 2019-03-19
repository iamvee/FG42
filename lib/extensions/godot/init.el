;;; IRCExtension --- Enables irc client on FG42
;;; Commentary:
;;; Code:

(defun setup-gdscript()
  (setq-default indent-tabs-mode nil)
  (setq tab-width 4)
  (setq gdscript-tabs-mode t)
  (setq gdscript-tab-width 4))

;;;###autoload
(defun extensions/godot-initialize ()
  (add-hook 'gdscript-mode-hook 'setup-gdscript)
  (message "Godot Engine extension has been loaded."))

(provide 'extensions/godot/init)
;;; init.el ends here
