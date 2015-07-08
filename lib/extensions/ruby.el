(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/ruby/init)

;; Dependencies ----------------------------------
(depends-on 'company-ruby)
(depends-on 'ruby-mode)
(depends-on 'slim-mode)
(depends-on 'haml-mode)


;; Extension -------------------------------------
(extension ruby
	   :version "2.67"
	   :on-initialize extension/ruby-initialize)

(provide 'extensions/ruby)
