(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))
(toggle-debug-on-error)
(require 'fg42)

;; Load the default theme
(theme themes/color-theme-monokai)

;; Activate these extensions
(activate-extensions 'editor
                     'development
                     'web
                     'editor-theme
                     'javascript
                     'php
                     'ruby)

;; Disable abilities which we do not want to load
(disable 'rbenv)

;; Load user config file in ~/.fg42
(load-user-config "~/.fg42")

(fg42-initialize)
