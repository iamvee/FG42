(require 'spacemacs-common)

(defun themes/color-theme-spacemacs-light-spaceline-faces (face active)
  (cond
     ((eq 'face1 face) (if active 'dired-mark 'powerline-inactive1))
     ((eq 'face2 face) (if active 'success 'mode-line-inactive))
     ((eq 'line face) (if active 'shadow 'shadow))
     ((eq 'highlight face) (if active 'dired-marked 'shadow))))

(defun themes/color-theme-spacemacs-light ()
  "Spacemacs light color theme"
  (interactive)
  (deftheme spacemacs-light "Spacemacs theme, the light version")
  (create-spacemacs-theme 'light 'spacemacs-light))

(provide 'themes/color-theme-spacemacs-light)
