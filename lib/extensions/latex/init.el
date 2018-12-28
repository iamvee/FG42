;;;###autoload
(defun extensions/latex-initialize ()
  ;;LaTeX development initialization
  (ability 'latex-ac ('code-completion)
           "Latex autocompletion support."
           (require 'company-auctex)
           (add-hook 'latex-mode #'company-auctex-init)))

(provide 'extensions/latex/init)
