(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/latex/init)

;; Dependencies ----------------------------------
(depends-on 'company-auctex)

(defun latex-doc ()
  "something fun")

;; Extension -------------------------------------
(extension latex
     :version "2."
     :on-initialize extensions/latex-initialize
     :docs "lib/extensions/latex/readme.org")

(provide 'extensions/latex)
