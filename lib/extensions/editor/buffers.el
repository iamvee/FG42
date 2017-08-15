;;; Buffers Module --- All the functions related to buffer management
;;; Commentary:
;;; Code:

(defvar *favorite-buffer* nil)

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun switch-to-buffer-by-regex ()
  "Switch to buffer which the name match the *favorite-buffer* regex."
  (interactive)
  (if *favorite-buffer*
    (switch-to-buffer
     (car (remove-if-not (apply-partially #'string-match-p *favorite-buffer*)
                         (buffer-list))))
    (eshell)))

(defun switch-to-favorite-buffer ()
  "Switch to *favorite-buffer* buffer with is variable assigned to each mode.

For exampe in clojure mode it would the name of repl buffer.  The *favorite-buffer* value should be regex matching to the buffer name"
  (interactive
    (if *favorite-buffer*
      (if (string-match *favorite-buffer* (buffer-name))
          (switch-to-previous-buffer)
          (switch-to-buffer-by-regex))
      (if (string= (buffer-name) "*eshell*") (switch-to-previous-buffer) (eshell)))))





(provide 'extensions/editor/buffers)
;;; buffers.el  ends here
