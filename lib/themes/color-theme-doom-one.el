(require 'doom-themes)
(require 'solaire-mode)

(defun themes/color-theme-doom-one ()
  (interactive)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'doom-one t)
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
