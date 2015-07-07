;; This library provides some basic means to create a new FG42 extensions
(require 'cl-lib)

;; Variables -----------------------------
(defvar activated-extensions ()
  "A list of all activated extensions.")

;; Structures -----------------------------
(cl-defstruct fg42-extension
  "Each FG42 extension should implement a copy of this structure."
  name
  (version nil)
  ;; Callbacks
  (on-initialize nil)
  (on-load))

(defmacro extension (name &rest args)
  "A simple DSL to define new fg42 extension."
  `(setq ,name (apply 'make-fg42-extension :name ,(symbol-name name) (quote ,args))))

(provide 'fg42/extension)
