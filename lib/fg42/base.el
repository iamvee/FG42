(require 'cl-lib)
(require 'fg42/extension)

;; Macros ---------------------------------
(defmacro theme (name)
  "Load the given theme name"
  `(progn
     (require ',(intern (symbol-name name)))
     (eval-after-load "color-theme"
     '(progn
        (color-theme-initialize)
        (,name)))))

;; Functions ------------------------------
(defun load--extension (extension)
  "Load a single extension and call its :on-initialize function"
  (let ((lib (concat "extensions/" (symbol-name extension))))
    (require (intern lib))))

(defun initialize--extension (extension)
  "Initialize given extension by calling its :on-initialize function."
  (let ((init-func (fg42-extension-on-initialize (symbol-value extension))))
    (funcall (symbol-function init-func))))

(defun initialize-extensions ()
  "Call the :on-initialize function on all extensions."
  (mapcar 'initialize--extension activated-extensions))

(defun activate-extensions (&rest extensions)
  "Mark given plugins to load on FG42"
  (setq activated-extensions extensions)
  (mapcar 'load--extension extensions))

(defun load-user-config (file)
  "Load the given path as user config file"
  (if (file-exists-p file)
      (load-file file)))


(provide 'fg42/base)
