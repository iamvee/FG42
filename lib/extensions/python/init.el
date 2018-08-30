;; Functions -------------------------------------------------
(defun setup-keybindings ()
  "Setup default key bindings for python mode"

  ;; FIXME: Replace the global key map with python-mode-map
  (global-set-key (kbd "C-c C-b") 'python-add-breakpoint)
  (global-set-key (kbd "C-c C-n") 'python-interactive))


(defun python--encoding-comment-required-p ()
  (re-search-forward "[^\0-\177]" nil t))

;;;###autoload
(defun python--detect-encoding ()
  (let ((coding-system
         (or save-buffer-coding-system
             buffer-file-coding-system)))
    (if coding-system
        (symbol-name
         (or (coding-system-get coding-system 'mime-charset)
             (coding-system-change-eol-conversion coding-system nil)))
      "ascii-8bit")))

;;;###autoload
(defun python--insert-coding-comment (encoding)
  (let ((newlines (if (looking-at "^\\s *$") "\n" "\n\n")))
    (insert (format "# coding: %s" encoding) newlines)))

;;;###autoload
(defun python-mode-set-encoding ()
  "Insert a magic comment header with the proper encoding if necessary."
  (save-excursion
    (widen)
    (goto-char (point-min))
    (when (prelude-python--encodings-comment-required-p)
      (goto-char (point-min))
      (let ((coding-system (python--detect-encoding)))
        (when coding-system
          (if (looking-at "^#!") (beginning-of-line 2))
          (cond ((looking-at "\\s *#\\s *.*\\(en\\)?coding\\s *:\\s *\\([-a-z0-9_]*\\)")
                 ;; update existing encoding comment if necessary
                 (unless (string= (match-string 2) coding-system)
                   (goto-char (match-beginning 2))
                   (delete-region (point) (match-end 2))
                   (insert coding-system)))
                ((looking-at "\\s *#.*coding\\s *[:=]"))
                (t (python--insert-coding-comment coding-system)))
          (when (buffer-modified-p)
            (basic-save-buffer-1)))))))

;;;###autoload
(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

;;;###autoload
(defun python-interactive ()
  "Enter the interactive Python environment"
  (interactive)
  (progn
    (newline-and-indent)
    (insert "from IPython import embed; embed()")
    (move-end-of-line 1)))


;;;###autoload
(defun python-mode-defaults ()
  "Defaults for Python programming."

                                        ;(require 'anaconda-mode)
                                        ;(require 'eldoc-mode)

  (subword-mode +1)
                                        ;(anaconda-mode 1)
  (eldoc-mode 1)

  (setup-keybindings)
  (with-ability auto-pair
                (setq-local electric-layout-rules
                            '((?: . (lambda ()
                                      (and (zerop (first (syntax-ppss)))
                                           (python-info-statement-starts-block-p)
                                           'after))))))

  ;; FIXME: we don't use imenu either remove this or
  ;;        setup imenu too
  (when (fboundp #'python-imenu-create-flat-index)
    (setq-local imenu-create-index-function
                #'python-imenu-create-flat-index))
  (add-hook 'post-self-insert-hook
            #'electric-layout-post-self-insert-function nil 'local)
                                        ;(add-hook 'after-save-hook 'python-mode-set-encoding nil 'local))
  )
;;;###autoload
(defun extensions/python-initialize ()
  (message "Initializing 'python' extension.")

  (ability elpy ()
           "Full feature python IDE. (A little bit heavy)"

           (require 'py-autopep8)

           (elpy-enable)

           (setq python-shell-interpreter "ipython"
                 python-shell-interpreter-args "-i --simple-prompt")

           ;; enable autopep8 formatting on save
           (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

           ;; use flycheck not flymake with elpy
           (when (require 'flycheck nil t)
             (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
             (add-hook 'elpy-mode-hook 'flycheck-mode)))

  (ability venv ()
           "Virtualenv support"
           (require 'virtualenvwrapper)
           (venv-initialize-interactive-shells)
           (venv-initialize-eshell)
           )
  (ability python-editor ()
           "Gives FG42 the ability to edit pytho codes."

           (add-hook 'python-mode-hook 'python-mode-defaults)
           (add-hook 'after-init-hook #'global-flycheck-mode)
           (when (fboundp 'exec-path-from-shell-copy-env)
             (exec-path-from-shell-copy-env "PYTHONPATH"))

           (with-ability kivy-editor
                         (add-to-list 'auto-mode-alist
                                      '("\\.kv\\'" . kivy-mode)))

           (with-ability cython-editor
                         (add-to-list 'auto-mode-alist
                                      '("\\.pyd\\'" . cython-mode))
                         (add-to-list 'auto-mode-alist
                                      '("\\.pyi\\'" . cython-mode))
                         (add-to-list 'auto-mode-alist
                                      '("\\.pyx\\'" . cython-mode))))


  (ability python-code-completion ('code-completion)
           "Gives FG42 the ability to complete python codes."

                                        ;(when (boundp 'company-backends)
                                        ;  (add-to-list 'company-backends 'company-anaconda))))
           ))

(provide 'extensions/python/init)
