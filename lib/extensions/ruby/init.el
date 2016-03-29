(require 'extensions/ruby/setup)

;; Functions -------------------------------------------------

;;;###autoload
(defun enh-ruby-mode-callback ()
  (setup-general-ruby-editor)
  (setup-inf-ruby)
  (setup-bundler)

  (global-set-key (kbd "M-.") 'my-find-tag)

  (with-ability rbenv
                (require 'rbenv)
                (global-rbenv-mode))

  (with-ability auto-pair
                (ruby-electric-mode t)))

;;;###autoload
(defun extensions/ruby-initialize ()
  "Web development plugin initialization."
  (message "Initializing 'ruby' extension.")

  (require 'enh-ruby-mode)
  (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)

  (with-ability global-rbenv
                (require 'rbenv)
                (global-rbenv-mode))

  (ability ruby-editor ('flycheck)
           "Gives FG42 the ability to edit ruby files."

           (dolist (spec '(("\\.rb$" . enh-ruby-mode)
                           ("[vV]agrantfile$" . enh-ruby-mode)
                           ("[gG]emfile$" . enh-ruby-mode)
                           ("[pP]uppetfile$" . enh-ruby-mode)
                           ("\\.rake$" . enh-ruby-mode)
                           ("\\.rabl$" . enh-ruby-mode)
                           ("[cC]apfile$" . enh-ruby-mode)
                           ("\\.gemspec$" . enh-ruby-mode)
                           ("\\.builder$" . enh-ruby-mode)))
             (add-to-list 'auto-mode-alist spec))

           (setq enh-ruby-use-encoding-map nil
                 ;; don't deep indent arrays and hashes
                 enh-ruby-deep-indent-paren nil)

           ;; Autostart yaml-mode
           (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
           (add-hook 'yaml-mode-hook
                     '(lambda ()
                        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

           ;; Add our callback to enh-ruby-mode-hook
           (add-hook 'enh-ruby-mode-hook 'enh-ruby-mode-callback)

           ;; configure hs-minor-mode
           (add-to-list 'hs-special-modes-alist
                        '(enh-ruby-mode
                          "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
                          (lambda (arg) (ruby-end-of-block)) nil))

           (add-hook 'enh-ruby-mode-hook 'projectile-mode))

  (ability ruby-code-completion ('code-completion)
           "Auto complete ruby code on demand."
           (add-to-list 'enh-ruby-mode-hook 'ruby-code-completion))

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
