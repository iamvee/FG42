(require 'cl-lib)
(require 'fg42/extension)

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

(provide 'fg42/base)
