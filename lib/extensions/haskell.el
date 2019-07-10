;;; HaskellExtension --- Enables haskell development on FG42
;;; Commentary:
;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/haskell/init)

;; Dependencies ----------------------------------
(depends-on 'haskell-mode)


(defun haskell-doc ()
  "something fun")

;; Extension -------------------------------------
(extension haskell
           :version "2.32"
           :on-initialize extensions/haskell-initialize
           :docs "lib/extensions/haskell/readme.org")

(provide 'extensions/haskell)
;;; haskell.el ends here
