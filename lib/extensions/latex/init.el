;;; latex-init --- The entry point for latex extension
;;; Commentary:
;;; Code:
(defun latex-run-lsp ()
  (interactive)
  "Run lsp-mode and set the texlab executable path."
  (require 'extensions/latex/lsp-latex)
  (setq lsp-latex-texlab-executable "texlab")
  (lsp))


;;;###autoload
(defun extensions/latex-initialize ()
  "Latex autocompletion support."
  (ability lsp-latex ('lsp)
           (add-hook 'tex-mode-hook 'latex-run-lsp)))

(provide 'extensions/latex/init)
;;; init.el ends here
