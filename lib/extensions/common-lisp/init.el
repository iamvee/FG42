;;; common-lisp-init --- The entry point for common lisp extension
;;; Commentary:
;;; Code:
(defvar default-lisp-platform "sbcl"
  "The default Lisp compiler/interpreter to be used with common-lisp extension.")

(defvar ql-slime-helper-path "~/quicklisp/slime-helper.el"
  "Default path for the slime-helper installed using quicklisp.")


;;;###autoload
(defun extensions/common-lisp-initialize ()
  "Initialize the common Lisp extension."
  (require 'slime)

  (setq inferior-lisp-program default-lisp-platform)
  (setq slime-contribs '(slime-fancy))
  (slime-setup '(slime-company))

  (add-hook 'slime-load-hook
            (lambda ()
              (define-key slime-prefix-map (kbd "M-h")
                'slime-documentation-lookup)))

  (let ((ql-slime-helper (expand-file-name ql-slime-helper-path)))
    (when (file-exists-p ql-slime-helper)
      (load ql-slime-helper))))

(provide 'extensions/common-lisp/init)
;;; init ends here
