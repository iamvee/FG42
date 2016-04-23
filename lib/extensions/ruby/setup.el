;;; Code:
;; Functions -------------------------------------------------

;;;###autoload
(defun insert-arrow ()
  (interactive)
  (delete-horizontal-space t)
  (insert " => "))

;;;###autoload
(defun setup-bundler ()
  "Setup bundler and its keybindings"
  (require 'bundler)
  (define-key enh-ruby-mode-map (kbd "\C-c b i") 'bundle-install)
  (define-key enh-ruby-mode-map (kbd "\C-c b u") 'bundle-update)
  (define-key enh-ruby-mode-map (kbd "\C-c b e") 'bundle-exec)
  (define-key enh-ruby-mode-map (kbd "\C-c b o") 'bundle-open)
  (define-key enh-ruby-mode-map (kbd "\C-c b c") 'bundle-console))

;;;###autoload
(defun rake-test ()
  (interactive)
  (let* ((root (or (rake--root) (user-error "Rakefile not found"))))
         (rake--with-root root (compile "rake test" 'rake-compilation-mode))))

;;;###autoload
(defun rake-migrate ()
  (interactive)
  (let* ((root (or (rake--root) (user-error "Rakefile not found"))))
         (rake--with-root root (compile "rake db:migrate" 'rake-compilation-mode))))

(defun rake-seed ()
  (interactive)
  (let* ((root (or (rake--root) (user-error "Rakefile not found"))))
         (rake--with-root root (compile "rake db:seed" 'rake-compilation-mode))))

;;;###autoload
(defun setup-rake ()
  "Setup bundler and its keybindings"
  (require 'rake)

  (eval-after-load 'projectile
    '(setq rake-completion-system projectile-completion-system))

  (define-key enh-ruby-mode-map (kbd "\C-c c r") 'rake)
  (define-key enh-ruby-mode-map (kbd "\C-c c t") 'rake-test)
  (define-key enh-ruby-mode-map (kbd "\C-c c m") 'rake-migrate)
  (define-key enh-ruby-mode-map (kbd "\C-c c s") 'rake-seed))

;;;###autoload
(defun setup-inf-ruby()
  "Setup inf-ruby and Robe"

  ;; Inf Ruby configuration
  (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)

  (global-set-key (kbd "C-c r r") 'inf-ruby)

  ;; TODO: We don't need this if pry setup is present in ~/.irbrc
  (setq irbparams " --inf-enh-ruby-mode -r irb/completion")
  (setq irbpath (rbenv--expand-path "shims" "irb"))
  (setq irb (concat irbpath irbparams))
  (add-to-list 'inf-ruby-implementations (cons "ruby" irb))
  (inf-ruby-minor-mode t))


;;;###autoload
(defun ruby-code-completion ()
  "Configure Robe and inf-ruby for code completion."
  (with-ability ruby-code-completion
                (robe-mode t)
                (define-key enh-ruby-mode-map (kbd "\C-c M-j") 'robe-start)
                (push 'company-robe company-backends)
                (eval-after-load 'company
                  '(add-to-list 'company-backends 'company-inf-ruby))))


;;;###autoload
(defun setup-general-ruby-editor ()
  "Setup basic utilities to write Ruby code"
  (local-set-key [f1] 'yari)

  ;; Install rspec snippets after it loaded
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets))

  (ruby-tools-mode t)
  (define-key enh-ruby-mode-map (kbd "C-.") 'insert-arrow)
  (hs-minor-mode t)
  ;; Hack autocomplete so it treat :symbole and symbole the same way
  (modify-syntax-entry ?: "."))


;;;###autoload
(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (projectile-project-root) "tags")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

;;;###autoload
(defun build-ctag-file ()
  "Create the ctag of the ruby project"
  (interactive)
  (message "building project tags")
  (let ((root (projectile-project-root)))
    (shell-command (concat "ctags -e -R . $(bundle list --paths) --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "tags " root)))
  (visit-project-tags)
  (message "tags built successfully"))

;;;###autoload
(defun my-find-tag ()
  (interactive)
  (if (file-exists-p (concat (projectile-project-root) "TAGS"))
      (visit-project-tags)
    (build-ctag-file))
  (etags-select-find-tag-at-point))

(provide 'extensions/ruby/setup)
