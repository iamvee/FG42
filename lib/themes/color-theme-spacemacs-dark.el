(require 'spacemacs-common)

(defun themes/color-theme-spacemacs-dark-spaceline-faces (face active)
  (cond
   ((eq 'face1 face) (if active 'minibuffer-prompt 'powerline-inactive1))
   ((eq 'face2 face) (if active 'success 'mode-line-inactive))
   ((eq 'line face) (if active 'shadow 'shadow))
   ((eq 'highlight face) (if active 'font-lock-function-name-face 'shadow))))

(defun themes/color-theme-spacemacs-dark ()
  "Spacemacs dark color theme"
  (interactive)
  (deftheme spacemacs-dark "Spacemacs theme, the dark version")
  (create-spacemacs-theme 'dark 'spacemacs-dark)
  (set-cursor-color "#d0d0de") )

(provide 'themes/color-theme-spacemacs-dark)
