(require 'doom-themes)

(defun themes/color-theme-doom-molokai-spaceline-faces (face active)
  (cond
     ((eq 'face1 face) (if active 'dired-mark 'powerline-inactive1))
     ((eq 'face2 face) (if active 'success 'mode-line-inactive))
     ((eq 'line face) (if active 'shadow 'shadow))
     ((eq 'highlight face) (if active 'dired-marked 'shadow))))

(defun themes/color-theme-doom-molokai ()
  (interactive)
  (load-theme 'doom-molokai t)

  (setq doom-enable-bold t
        doom-enable-italic t  ; if nil, italics are universally disabledc
        doom-molokai-brighter-modeline nil
        doom-molokai-brighter-comments nil))

(provide 'themes/color-theme-doom-molokai)
