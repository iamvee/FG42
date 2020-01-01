;;; serene-init --- The entry point for serene extension
;;; Commentary:
;;; Code:
(defvar serene-simple-mode-map
  (make-sparse-keymap))


(defconst serene-simple-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\" "\"" table)
    ;; / is punctuation, but // is a comment starter
    (modify-syntax-entry ?\; "<" table)
    (modify-syntax-entry ?\n ">" table)
    table))


(defface serene-simple-mode-special-froms-face
  '((t :inherit font-lock-builtin-face))
  "Face of special forms."
  :group 'simple-serene-mode)

(defface serene-simple-mode-builtin-fns-face
  '((t :inherit font-lock-keyword-face))
  "Face of builtin functions."
  :group 'simple-serene-mode)

(defface serene-simple-mode-builtin-types-face
  '((t :inherit font-lock-type-face))
  "Face of built in types."
  :group 'simple-serene-mode)

(defvar serene-simple-mode-special-forms
  '("do" "let" "def" "fn" "quote" "cond" "if"))


(defconst serene-simple-mode-builtin-fns
  '("=" ">" "<" ">=" "<=" "and" "or" "not" "first" "rest" "println"
    "quit" "+" "*" "/" "-" "conj" "mod" "new"))


(defconst serene-simple-mode-builtin-types
  '("System" "String" "Boolean"))


(define-derived-mode serene-simple-mode
  scheme-mode "Serene(Simple)"
  "Major mode for Serene simple.")



(defun serene-simple-add-keywords (face-name keyword-rules)
  "Set the FACE-NAME for keywords in serene-simple using KEYWORD-RULES."
  (let* ((keyword-list (mapcar #'(lambda (x)
                                   (symbol-name (cdr x)))
                               keyword-rules))
         (keyword-regexp
          (concat
           "\\("
           (regexp-opt keyword-list)
           "\\)")))
    (font-lock-add-keywords 'serene-simple-mode
                            `((,keyword-regexp 1 ',face-name))))
  (mapc #'(lambda (x)
            (put (cdr x)
                 'serene-simple-indent-function
                 (car x)))
        keyword-rules))


(serene-simple-add-keywords 'serene-simple-mode-special-froms-face
                            (mapcar (lambda (x) (cons 1 (intern x))) serene-simple-mode-special-forms))

(serene-simple-add-keywords 'serene-simple-mode-builtin-fns-face
                            (mapcar (lambda (x) (cons 1 (intern x))) serene-simple-mode-builtin-fns))

(serene-simple-add-keywords 'serene-simple-mode-builtin-types-face
                            (mapcar (lambda (x) (cons 1 (intern x))) serene-simple-mode-builtin-types))

(provide 'extensions/serene/serene-simple-mode)
;;; serene-simple-mode.el ends here
