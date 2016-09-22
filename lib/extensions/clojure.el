(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/clojure/init)

;; Dependencies ----------------------------------
(depends-on 'clojure-mode)
(depends-on 'cider)
(depends-on 'hl-sexp)
(depends-on 'paredit)
(depends-on 'flycheck)
(depends-on 'flycheck-clojure)
(depends-on 'clj-refactor)
(depends-on 'let-alist)
(depends-on 'flycheck-clojure)
(depends-on 'clojure-mode-extra-font-locking)
;(depends-on 'core-async-mode)
(depends-on 'yesql-ghosts)

;; Extension -------------------------------------
(extension clojure
	   :version "2.31"
	   :on-initialize extensions/clojure-initialize)

(provide 'extensions/clojure)
