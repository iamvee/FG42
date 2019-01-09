;;; IRCExtension --- Enables irc client on FG42
;;; Commentary:
;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/irc/init)

;; Dependencies ----------------------------------
(depends-on 'rcirc-notify)

(defun irc-doc ()
  "TBD"
  "TBD")

;; Extension -------------------------------------
(extension irc
     :version "2.32"
     :on-initialize extensions/irc-initialize
     :docs "lib/extensions/irc/readme.org")

(provide 'extensions/irc)
;;; irc.el ends here
