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
               (ability lsp-java ('lsp)
                        (setq lsp-java-server-install-dir fg42-tmp)
                        (lsp))
               (ability dap-java ('dap)
                        (require 'dap-java))
               (gradle-mode 1))))


(provide 'extensions/java/init)
;;; init ends here
