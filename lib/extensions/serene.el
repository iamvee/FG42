;;; SereneExtension --- Enables Serene development on FG42
;;; Commentary:
;;; Code:

(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/serene/init)

;; Dependencies ----------------------------------
(depends-on 'paredit)
(depends-on 'parinfer)
(depends-on 'rainbow-delimiters)

(defun serene-doc ()
  "something fun")
;; Extension -------------------------------------
(extension serene
     :version "2.32"
     :on-initialize extensions/serene-initialize
           :docs "lib/extensions/serene/readme.org")

(provide 'extensions/serene)
;;; serene.el ends here
