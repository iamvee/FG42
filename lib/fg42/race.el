;;; Race --- A utitlity to tweak shortkeys based on user preference
;;; Commentary:
;;; Code:
(defvar fg42-user-race :god
  "The race of the user.")

(defun i-am (race)
  "Set the user race to the given RACE."
  (if (member race '(:god :human :evil))
      (setq fg42-user-race race)
    (error "Invalid race '%s'.  Choices are ':god', ':human', ':evil'" race)))

(defun i-am-evil ()
  "Set the user race to :evil."
  (interactive)
  (setq fg42-user-race :evil))

(defun i-am-god ()
  "Set the user race to :god."
  (interactive)
  (setq fg42-user-race :god))

(defun i-am-human ()
  "Set the user race to :human."
  (interactive)
  (setq fg42-user-race :human))

(defun is-evil? ()
  "Is user a evil?"
  (interactive)
  (eq fg42-user-race :evil))

(defun is-god? ()
  "Is user a god?"
  (interactive)
  (eq fg42-user-race :god))

(defun is-human? ()
  "Is user a human?"
  (interactive)
  (eq fg42-user-race :human))

(provide 'fg42/race)
;;; race.el ends here
