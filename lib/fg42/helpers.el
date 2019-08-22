;;; Helpers --- Helper functions of FG42
;;; Commentary:
;;; Code:
(require 'cl-lib)

;;;###autoload
(defun what-face (pos)
  "Return the face of the thing at the current POS."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


;;;###autoload
(defun env (&rest args)
  "Setup environment variables given as ARGS."
  (require 'seq)
  (let ((pairs (seq-partition args 2)))
    (dolist (pair pairs)
      (progn (setenv (substring (symbol-name (car pair)) 1) (car (cdr pair)))))))


(provide 'fg42/helpers)
;;; helpers ends here
