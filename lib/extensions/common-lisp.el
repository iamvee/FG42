(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/common-lisp/init)

;; Dependencies ----------------------------------
(depends-on 'paredit)
(depends-on 'flycheck)
(depends-on 'rainbow-delimiters)
(depends-on 'slime)
(depends-on 'slime-company)

(defun common-lisp-doc ()
  "")

;; Extension -------------------------------------
(extension common-lisp
           :version "2.32"
           :on-initialize extensions/common-lisp-initialize
           :docs "lib/extensions/common-lisp/readme.org")

(provide 'extensions/common-lisp)
