(require 'dracula-theme)

(defun themes/color-theme-dracula-spaceline-faces (face active)
  (cond
     ((eq 'face1 face) (if active 'minibuffer-prompt 'powerline-inactive1))
     ((eq 'face2 face) (if active 'success 'mode-line-inactive))
     ((eq 'line face) (if active 'shadow 'shadow))
     ((eq 'highlight face) (if active 'match 'shadow))))

(defun themes/color-theme-dracula ()
  (interactive)
  ;; Global settings (defaults)
  ;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  ;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'dracula t)

  (custom-theme-set-faces
   'dracula
   '(minibuffer-prompt ((t (:background "#373844"))))
   '(powerline-inactive1 ((t (:background "#282a36"))))
   '(match ((t (:background "#bd93f9"))))
   '(all-the-icons-lgreen ((t (:background "#bd93f9"))))
   '(all-the-icons-faicon ((t (:background "#bd93f9"))))
   '(mode-line-inactive ((t (:background "#282a36"))))

   '(font-lock-comment-face ((t (:foreground "#8B9298"))))
   '(font-lock-comment-delimiter-face ((t (:foreground "#5B6268")))))

  (enable-theme 'dracula)
  ;; brighten buffers (that represent real files)
  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)

  ;; You can do similar with the minibuffer when it is activated:
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

  ;; ...if you use auto-revert-mode:
  (add-hook 'after-revert-hook #'turn-on-solaire-mode)

  ;; To enable solaire-mode unconditionally for certain modes:
  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode))

  ;; Enable custom neotree theme
  ;;(doom-themes-neotree-config))


(provide 'themes/color-theme-dracula)
