;;; RacketExtension --- Enables Racket development on FG42
;;; Commentary:
;;; Code:

;;;###autoload
(defun extensions/racket-initialize ()
  "Initialize the racket extension."
  (ability racket-editor ('flycheck)
           (require 'racket-mode)

           (add-to-list 'auto-mode-alist '("\\.rkts$" . racket-mode))
           (add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))
           (add-to-list 'auto-mode-alist '("\\.rktl$" . racket-mode))
           (add-to-list 'auto-mode-alist '("\\.rktd$" . racket-mode))

           (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
           (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
           (add-hook 'racket-mode-hook #'paredit-mode)
           (add-hook 'racket-mode-hook #'rainbow-delimiters-mode)
           (setq tmp-directory (concat (getenv "HOME") "/.tmp")))

  (with-ability parinfer ()
                (add-hook 'racket-mode-hook #'parinfer-mode)))


(provide 'extensions/racket/init)
;;; init.el ends here
