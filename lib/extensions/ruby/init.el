;; Functions -------------------------------------------------

;;;###autoload
(defun ruby-mode-callback ()
  (require 'bundler)
  (robe-mode t)

  (local-set-key [f1] 'yari)
  (global-rbenv-mode)
  (global-set-key (kbd "C-c r r") 'inf-ruby)

  (define-key ruby-mode-map (kbd "\C-c b i") 'bundle-install)
  (define-key ruby-mode-map (kbd "\C-c b u") 'bundle-update)
  (define-key ruby-mode-map (kbd "\C-c b e") 'bundle-exec)
  (define-key ruby-mode-map (kbd "\C-c b o") 'bundle-open)
  (define-key ruby-mode-map (kbd "\C-c b c") 'bundle-console)

  (push 'company-robe company-backends)
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets))

  (setq irbparams " --inf-ruby-mode -r irb/completion")
  (setq irbpath (rbenv--expand-path "shims" "irb"))
  (setq irb (concat irbpath irbparams))
  (add-to-list 'inf-ruby-implementations (cons "ruby" irb))
  (inf-ruby-minor-mode t)

  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-inf-ruby))

  (with-ability auto-pair
                ;; Disable autopaire
                ;;(autopair-global-mode -1))
                )

  (ruby-tools-mode t)
  (ruby-electric-mode t)
(define-key ruby-mode-map (kbd "C-.") 'insert-arrow)
(global-set-key (kbd "C-c r r") 'inf-ruby)

  ;; Enable flycheck
  ;;(flycheck-mode t)

  ;; hs mode
  ;;(hs-minor-mode t)
  ;; Hack autocomplete so it treat :symbole and symbole the same way
  (modify-syntax-entry ?: "."))


;;;###autoload
(defun insert-arrow ()
  (interactive)
  (delete-horizontal-space t)
  (insert " => "))

;;;###autoload
(defun extensions/ruby-initialize ()
  "Web development plugin initialization."
  (message "Initializing 'ruby' extension.")

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

           ;; Inf Ruby configuration
           (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
           (add-hook 'ruby-mode-hook 'ruby-mode-callback)
           (add-hook 'after-init-hook 'inf-ruby-switch-setup)

           ;; configure hs-minor-mode
           (add-to-list 'hs-special-modes-alist
                        '(ruby-mode
                          "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
                          (lambda (arg) (ruby-end-of-block)) nil))

           (add-hook 'ruby-mode-hook 'projectile-mode))


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
