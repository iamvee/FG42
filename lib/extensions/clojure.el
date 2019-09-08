(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/clojure/init)

;; Dependencies ----------------------------------
(depends-on 'clojure-mode)
(depends-on 'cider)
(depends-on 'paredit)
(depends-on 'flycheck)
(depends-on 'flycheck-clojure)
(depends-on 'clj-refactor)
(depends-on 'let-alist)
(depends-on 'clojure-mode-extra-font-locking)

;(depends-on 'core-async-mode)
(depends-on 'yesql-ghosts)
(depends-on 'rainbow-delimiters)

(defun clojure-doc ()
  "something fun")
;; Extension -------------------------------------
(extension clojure
	   :version "2.32"
	   :on-initialize extensions/clojure-initialize
           :docs "lib/extensions/clojure/readme.org")

(provide 'extensions/clojure)
