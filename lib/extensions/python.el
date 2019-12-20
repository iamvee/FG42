(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/python/init)

;; Dependencies ----------------------------------
(depends-on 'virtualenvwrapper)
(depends-on 'flycheck)
(depends-on 'pyvenv)
(depends-on 'py-autopep8)

(with-ability anaconda
              (depends-on 'anaconda-mode)
              (depends-on 'company-anaconda))

(with-ability jedi
              (depends-on 'company-jedi))

(with-ability elpy
              (depends-on 'ein)
              (depends-on 'elpy))

(with-ability kivy-editor
              (depends-on 'kivy-mode))

(with-ability cython-editor
              (depends-on 'cython-mode))

(with-ability lsp-python
              (depends-on 'lsp-python-ms))

(with-ability python-black
              (depends-on 'python-black))

;; Extension -------------------------------------
(extension python
	   :version "2.31"
	   :on-initialize extensions/python-initialize)

(provide 'extensions/python)
