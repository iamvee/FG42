;;;###autoload
(defun extensions/latex-initialize ()
  ;;LaTeX development initialization
  (ability lsp-latex ('lsp)
           "Latex autocompletion support."
	   (setq lsp-latex-texlab-executable "/home/velorin/texlab-x86_64-linux/texlab")
           (require 'extensions/latex/lsp-latex)
	   (add-hook 'tex-mode-hook 'lsp)
	   (add-hook 'latex-mode-hook 'lsp)))


(provide 'extensions/latex/init)
