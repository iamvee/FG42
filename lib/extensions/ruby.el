(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/ruby/init)

;; Dependencies ----------------------------------
(depends-on 'company-inf-ruby)
(depends-on 'enh-ruby-mode)
(depends-on 'rbenv)
(depends-on 'slim-mode)
(depends-on 'haml-mode)
(depends-on 'inf-ruby)
(depends-on 'ruby-tools)
(depends-on 'yaml-mode)
(depends-on 'ruby-electric)
(depends-on 'bundler)
(depends-on 'feature-mode)
(depends-on 'rspec-mode)
(depends-on 'projectile-rails)
(depends-on 'robe)
(depends-on 'yari)

;; Extension -------------------------------------
(extension ruby
	   :version "2.31"
	   :on-initialize extensions/ruby-initialize)

(provide 'extensions/ruby)
