(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/python/init)

;; Dependencies ----------------------------------
(depends-on 'anaconda-mode)
(depends-on 'company-anaconda)
(depends-on 'pyvenv)

(with-ability kivy-editor
              (depends-on 'kivy-mode))

(with-ability cython-editor
              (depends-on 'cython-mode))

;; Extension -------------------------------------
(extension python
	   :version "2.31"
	   :on-initialize extensions/python-initialize)

(provide 'extensions/python)
