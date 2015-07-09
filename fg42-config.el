(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))
(toggle-debug-on-error)
(require 'fg42)

;; Activate these extensions
(activate-extensions 'editor
                     'development
                     'web
                     'ruby)

;; Disable abilities which we do not want to load
(disable 'rbenv)

;; Load user config file in ~/.fg42
(load-user-config "~/.fg42")

(fg42-initialize)
