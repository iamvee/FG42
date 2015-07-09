(add-to-list 'load-path (concat (getenv "FG42_HOME") "/lib"))
(toggle-debug-on-error)
(require 'fg42)

(activate-extensions 'editor
                     'development
                     'web
                     'ruby)

(disable 'rbenv)
(describe-variable disabled-abilities)
(fg42-initialize)
