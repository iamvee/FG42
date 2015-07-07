(require 'cl-lib)
(require 'fg42/extension)

(defun load--extension (extension)
  "Load a single extension and call its :on-initialize function"
  (let ((lib (concat "extensions/" (symbol-name extension)))
	(init-func nil))
    
    (require (intern lib))
    (setq init-func (fg42-extension-on-initialize (symbol-value extension)))
    (funcall (symbol-function init-func))))


(defun enable-extensions (&rest extensions)
  "Mark given plugins to load on FG42"
  (mapcar 'load--extension extensions))


(provide 'fg42/base)
