;;;###autoload
(defun extensions/latex-initialize ()
  "Latex autocompletion support."
  (ability lsp-latex ('lsp)
           (with-eval-after-load "tex-mode"
             (add-hook 'latex-mode-hook 'latex-mode-hook
	               '(lambda()
                          (require 'extensions/latex/lsp-latex)
		          (setq lsp-latex-texlab-executable "/usr/bin/texlab")
		          (lsp))))))

(provide 'extensions/latex/init)
