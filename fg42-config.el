(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))
(toggle-debug-on-error)
(require 'fg42)

(activate-extensions 'editor
                     'development
                     'web)

(fg42-initialize)
