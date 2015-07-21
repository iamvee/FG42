(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/python/init)

;; Dependencies ----------------------------------
(depends-on 'anaconda-mode)
(depends-on 'company-anaconda)
(depends-on 'pyvenv)

;; Extension -------------------------------------
(extension python
	   :version "1.0"
	   :on-initialize extensions/python-initialize)

(provide 'extensions/python)
