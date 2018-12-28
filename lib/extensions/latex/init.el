(defun extensions/latex-initialize ()
  ;LaTeX development initialization
(require 'company-auctex)
(add-hook 'latex-mode #'company-auctex-init))

(provide 'extensions/latex/init)
