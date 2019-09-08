;;; RacketExtension --- Enables Racket development on FG42
;;; Commentary:
;; In order to user racket extension `racket' itself should
;; be available on the path provided by `exec-path'.
;;; Code:

(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/racket/init)

;; Dependencies ----------------------------------
(depends-on 'racket-mode)
(depends-on 'paredit)
(depends-on 'flycheck)
(depends-on 'clojure-mode-extra-font-locking)
(depends-on 'rainbow-delimiters)

(defun racket-doc ()
  "Something fun.")

;; Extension -------------------------------------
(extension racket
           :version "2.32"
           :on-initialize extensions/racket-initialize
           :docs "lib/extensions/racket/readme.org")

(provide 'extensions/racket)
;;; racket.el ends here
