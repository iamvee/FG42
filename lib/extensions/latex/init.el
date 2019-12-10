(defun latex-run-lsp ()
  (require 'extensions/latex/lsp-latex)
  (setq lsp-latex-texlab-executable "texlab")
  (lsp))


;;;###autoload
(defun extensions/latex-initialize ()
  "Latex autocompletion support."
  (ability lsp-latex ('lsp)
           (add-hook 'tex-mode-hook 'latex-run-lsp)))

(provide 'extensions/latex/init)
