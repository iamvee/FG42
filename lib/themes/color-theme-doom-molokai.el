(require 'doom-themes)

(defun themes/color-theme-doom-molokai ()
  (interactive)
  (load-theme 'doom-molokai t)

  (setq doom-enable-bold t
        doom-enable-italic t  ; if nil, italics are universally disabledc
        doom-molokai-brighter-modeline nil
        doom-molokai-brighter-comments nil))

(provide 'themes/color-theme-doom-molokai)
