;;;###autoload
(defun extensions/latex-initialize ()
"Latex autocompletion support."
	   (require 'extensions/latex/lsp-latex)
	   (with-eval-after-load "tex-mode"
	     (add-hook 'latex-mode-hook 'latex-mode-hook
		       '(lambda()
			  (ability lsp-latex ('lsp)
				   (setq lsp-latex-texlab-executable "/usr/bin/texlab")
				   (lsp))))))

(provide 'extensions/latex/init)
