;;; java-init --- The entry point for common lisp extension
;;; Commentary:
;;; Code:

;;;###autoload
(defun extensions/java-initialize ()
  "Initialize the common Lisp extension."

  (add-to-list 'auto-mode-alist
               '("\\.gradle\\'" . groovy-mode))

  (require 'gradle-mode)
  (add-hook 'java-mode-hook
            '(lambda()
               ;; To fix the indentation of function arguments
               (c-set-offset 'arglist-intro '+)
               (setq java-basic-offset 2)
               (setq c-basic-offset 2)
               (setq c-offsets-alist '((arglist-cont-nonempty . +)))
               (ability lsp-java ('lsp)
                        (setq lsp-java-server-install-dir fg42-tmp)
                        (lsp))
               (ability dap-java ('dap)
                        (require 'dap-java))
               (gradle-mode 1))))


(provide 'extensions/java/init)
;;; init ends here
