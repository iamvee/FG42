(require 'rake)

;;;###autoload
(defun my-rake (task &optional compilation-mode)
  "Runs rake command."
  (let* ((root (or (rake--root) (user-error "Rakefile not found")))
         (arg (or (car arg) 0))
         (prefix (rake--choose-command-prefix root
                                              (list :spring  "bundle exec spring rake "
                                                    :zeus    "zeus rake "
                                                    :bundler "bundle exec rake "
                                                    :vanilla "rake ")))
         (mode (or compilation-mode 'rake-compilation-mode)))
    (rake-compile root task mode)))

(provide 'my-rake)
