(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))
(toggle-debug-on-error)
(require 'fg42)

;; Load the default theme
(theme themes/color-theme-monokai)

;; Disable abilities which we do not want to load
(disable 'rbenv 'helm 'swiper)

;; Activate these extensions
(activate-extensions 'editor
                     'development
                     'web
                     'editor-theme
                     ;'arduino
                     'javascript
                     ;'php
                     'clojure
                     ;'python
                     'ruby
		     )

;; Load user config file in ~/.fg42
(load-user-config "~/.fg42")

(fg42-initialize)
