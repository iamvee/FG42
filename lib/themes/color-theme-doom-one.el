(require 'doom-themes)

(defun themes/color-theme-doom-one ()
  (interactive)
  (load-theme 'doom-one t)

  (setq doom-enable-bold t
        doom-enable-italic t  ; if nil, italics are universally disabledc
        doom-one-brighter-modeline nil
        doom-one-brighter-comments nil)

  ;; brighter source buffers (that represent files)
  (add-hook 'find-file-hook 'doom-buffer-mode-maybe)

  ;; if you use auto-revert-mode
  (add-hook 'after-revert-hook 'doom-buffer-mode-maybe)

  ;; you can brighten other buffers (unconditionally) with:
  (add-hook 'ediff-prepare-buffer-hook 'doom-buffer-mode)

  ;; brighter minibuffer when active
  (add-hook 'minibuffer-setup-hook 'doom-brighten-minibuffer)

  ;; Enable custom neotree theme
  (require 'doom-neotree)    ; all-the-icons fonts must be installed!

  ;; Enable nlinum line highlighting
  (require 'doom-nlinum))

(provide 'themes/color-theme-doom-one)
