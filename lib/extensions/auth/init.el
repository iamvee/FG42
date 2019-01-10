;;; Auth --- Secret management extension for FG42
;;; Commentary:
;;; Code:
(require 'auth-source)

(defvar auht/sources '((:sources "~/.authinfo.gpg")))

(defun auth/find-credential (host)
  "Find the credential for the given HOST.
Return a list of credential pairs."
  (let (auth-list '())
    (dolist (cred (auth-source-search :host host
                                      :require '(:user :secret)))
      (let ((user   (plist-get cred :user))
            (secret (plist-get cred :secret)))
        (add-to-list 'auth-list
                     (list user
                           (if (functionp secret)
                               (funcall secret)
                             secret)))))
    auth-list))

(defun utils/bold (text)
  "Make the TEXT appears in bold form."
  (propertize text 'face 'bold))


(defun auth/credential-for (args host)
  "Return the credential for the given HOST.
ARGS should be ignored."
  (interactive "P\nsHost: ")
  (dolist (pair (auth/find-credential host))
    (message (concat "User: " (utils/bold (car pair))
                     " Passowrd: " (utils/bold(car (cdr pair)))))))

(auth/credential-for nil "freenode")
(auth/find-credential "freenode")

(defun extensions/irc-initialize ()
  "Initialize the Auth extension."
  (setq auth-sources auth/sources))

(provide 'extensions/irc/init)
;;; init.el ends here
