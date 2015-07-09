(require 'extensions/ruby/setup)

;; Functions -------------------------------------------------

;;;###autoload
(defun ruby-mode-callback ()

  (setup-general-ruby-editor)
  (setup-inf-and-robe)
  (setup-bundler)

  (with-ability rbenv
                (require 'rbenv)
                (global-rbenv-mode))

  (with-ability auto-pair
                (ruby-electric-mode t)))


;;;###autoload
(defun extensions/ruby-initialize ()
  "Web development plugin initialization."
  (message "Initializing 'ruby' extension.")

  (with-ability global-rbenv
                (require 'rbenv)
                (global-rbenv-mode))

  (ability ruby-editor ('flycheck)
           "Gives FG42 the ability to edit ruby files."
           (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
           (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
           (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
           (add-to-list 'auto-mode-alist '("gemspec$" . ruby-mode))
           (add-to-list 'auto-mode-alist '("config.ru$" . ruby-mode))
           (add-to-list 'auto-mode-alist '("json.jbuilder$" . ruby-mode))

           (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
           (add-hook 'yaml-mode-hook
                     '(lambda ()
                        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


           (add-hook 'ruby-mode-hook 'ruby-mode-callback)

           ;; configure hs-minor-mode
           (add-to-list 'hs-special-modes-alist
                        '(ruby-mode
                          "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
                          (lambda (arg) (ruby-end-of-block)) nil))

           (add-hook 'ruby-mode-hook 'projectile-mode))

  (ability ruby-code-completion ('code-completion)
           "Auto complete ruby code on demand."
           (add-to-list 'ruby-mode-hook 'ruby-code-completion))

  (ability slim-mode ()
           "Gives FG42 the ability to edit slim templates."
           (add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode)))

  (ability haml-mode ()
           "Gives FG42 the ability to edit haml templates."
           (add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode)))

  (ability cucumber ()
           "Gives FG42 the ability to works with Cucumber."
           (autoload 'feature-mode "feature-mode"
             "Emacs mode for editing Cucumber plain text stories")
           (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode)))

  (ability rails-projects ()
           "Gives FG42 the ability to manage rails projects."
           (add-hook 'projectile-mode-hook 'projectile-rails-on)))


(provide 'extensions/ruby/init)
