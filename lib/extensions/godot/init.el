;;; Godot --- Enables Godot game engine integration with FG42
;;; Commentary:
;;; Code:

;; (defun setup-gdscript()
;;   (setq-default indent-tabs-mode nil)
;;   (setq tab-width 2)
;;   (setq gdscript-tabs-mode t)
;;   (setq gdscript-tab-width 2))

(defun setup-gdscript()
  (interactive)
  (setq tab-width 2)
  (setq indent-tab-mode nil))

;;;###autoload
(defun extensions/godot-initialize ()

  (require 'extensions/godot/godot-gdscript)
  (add-to-list 'auto-mode-alist '("\\.gd$" . godot-gdscript-mode))
  (add-hook 'godot-gdscript-mode-hook 'setup-gdscript)
  (message "Godot Engine extension has been loaded."))

(provide 'extensions/godot/init)
;;; init.el ends here
