(require 'dracula-theme)

(defun themes/color-theme-doom-one-spaceline-faces (face active)
  (cond
     ((eq 'face1 face) (if active 'minibuffer-prompt 'powerline-inactive1))
     ((eq 'face2 face) (if active 'success 'mode-line-inactive))
     ((eq 'line face) (if active 'shadow 'shadow))
     ((eq 'highlight face) (if active 'match 'shadow))))

(defun themes/color-theme-doom-one ()
  (interactive)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'doom-one t)

  (custom-theme-set-faces
   'doom-one
   '(font-lock-comment-face ((t (:foreground "#8B9298"))))
   '(font-lock-comment-delimiter-face ((t (:foreground "#5B6268")))))

  (enable-theme 'doom-one)
  ;; brighten buffers (that represent real files)
  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)

  ;; You can do similar with the minibuffer when it is activated:
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

  ;; ...if you use auto-revert-mode:
  (add-hook 'after-revert-hook #'turn-on-solaire-mode)

  ;; To enable solaire-mode unconditionally for certain modes:
  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

  ;; Enable custom neotree theme
  (doom-themes-neotree-config))


(provide 'themes/color-theme-doom-one)
