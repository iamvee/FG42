;;; Auth --- Secret management extension for FG42
;;; Commentary:
;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/auth/init)

;; Dependencies ----------------------------------
(depends-on 'rcauth-notify)

(defun auth-doc ()
  "TBD"
  "TBD")

;; Extension -------------------------------------
(extension auth
     :version "2.32"
     :on-initialize extensions/auth-initialize
     :docs "lib/extensions/auth/readme.org")

(provide 'extensions/auth)
;;; auth.el ends here
