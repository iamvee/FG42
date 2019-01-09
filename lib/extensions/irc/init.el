;;; IRCExtension --- Enables irc client on FG42
;;; Commentary:
;;; Code:
(defvar irc-servers
  '(("irc.freenode.net"
     :port 6697
     :encryption tls
     :channels ("#5hit")))
  "A list of servers and channels to connect to.")

(defvar irc-auth nil
  "The irc authentication credentials.
This would overridethe default behaviour which is based onauth-sources.")

(defun irc/extract-secrets-from-auth-source ()
  "Extract the irc authenticate data from the auth-sources.

As an example for ~/.authinfo.gpg should contain:

machine freenode login <nickname> port nickserv password <password>

Also the auth-sources should be set correctly.
It returns nil if no password is available."
  (let ((auth-list '()))
    (dolist (p (auth-source-search :port '("nickserv")
                                   :require '(:port :user :secret)))
        (let ((secret (plist-get p :secret))
              (method (intern (plist-get p :port))))

          (add-to-list 'auth-list
                       (list (plist-get p :host)
                             method
                             (plist-get p :user)
                             (if (functionp secret)
                                 (funcall secret)
                               secret)))))
    auth-list))


;;;###autoload
(defun irc/setup ()
  "Setup the rcirc library which distributes with Emacs."
  (set (make-local-variable 'scroll-conservatively) 8192)
  (setq gnutls-min-prime-bits 2048))

(defun irc/connect ()
  "Connects to IRC."
  (interactive)
  (require 'rcirc)
  (require 'rcirc-notify)

  ;; Turns off keychain integration
  (setenv "GPG_AGENT_INFO" nil)

  ;; Turn on debugging if the global debuging was enabled
  (setq rcirc-debug-flag debug-on-error)
  (setq rcirc-server-alist irc-servers)
  (setq rcirc-authinfo (or (irc/extract-secrets-from-auth-source)
                           irc-auth))
  (rcirc-notify-add-hooks)
  (rcirc nil))


;;;###autoload
(defun extensions/irc-initialize ()
  "Initialize the irc extention."

  ;; Keep input line at bottom.
  (add-hook 'rcirc-mode-hook 'irc/setup)

  (ability irc-spell-checking ()
           (add-hook 'rcirc-mode-hook (lambda ()
                                        (flyspell-mode 1)))))
                                        ;

(provide 'extensions/irc/init)
;;; init.el ends here
