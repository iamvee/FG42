;;; john_titor --- RPC client for john_titor
;;; Commentary:
;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/john_titor/init)

;; Dependencies ----------------------------------
(depends-on 'emacs-epc)

(defun john_titor-doc ()
  "TBD"
  "TBD")

;; Extension -------------------------------------
(extension john_titor
     :version "2.32"
     :on-initialize extensions/john_titor-initialize
     :docs "lib/extensions/john_titor/readme.org")

(provide 'extensions/john_titor)
;;; john_titor.el ends here
