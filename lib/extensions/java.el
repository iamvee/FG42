;;; JavaExtension --- Enables java development on FG42
;;; Commentary:
;;; Code:

(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/java/init)

;; Dependencies ----------------------------------

(depends-on 'gradle-mode)

(with-ability lsp-java
              (depends-on 'lsp-java))


(defun java-doc ()
  "TBD")

;; Extension -------------------------------------
(extension java
           :version "2.32"
           :on-initialize extensions/java-initialize
           :docs "lib/extensions/java/readme.org")

(provide 'extensions/java)
;;; java.el ends here
