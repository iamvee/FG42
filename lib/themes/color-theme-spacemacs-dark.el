(require 'spacemacs-common)

(defun themes/color-theme-spacemacs-dark ()
  "Spacemacs dark color theme"
  (interactive)
  (deftheme spacemacs-dark "Spacemacs theme, the dark version")
  (create-spacemacs-theme 'dark 'spacemacs-dark)
  (set-cursor-color "#d0d0de") )

(provide 'themes/color-theme-spacemacs-dark)
