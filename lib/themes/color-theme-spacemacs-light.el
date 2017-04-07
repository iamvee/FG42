(require 'spacemacs-common)

(defun themes/color-theme-spacemacs-light ()
  "Spacemacs light color theme"
  (interactive)
  (deftheme spacemacs-light "Spacemacs theme, the light version")
  (create-spacemacs-theme 'light 'spacemacs-light))

(provide 'themes/color-theme-spacemacs-light)
