;;; fg42-theme --- Official fg42 theme
;;; Commentary:
;;; Code:
(defun themes/fg42-theme-spaceline-faces (face active)
  (cond
     ((eq 'face1 face) (if active 'minibuffer-prompt 'powerline-inactive1))
     ((eq 'face2 face) (if active 'success 'mode-line-inactive))
     ((eq 'line face) (if active 'shadow 'shadow))
     ((eq 'highlight face) (if active 'match 'shadow))))

(defun themes/fg42-theme ()
  (interactive)
  (load-theme 'fg42-doom-one t t)
  (enable-theme 'fg42-doom-one))

(provide 'themes/fg42-theme)
;;; fg42-theme ends here
