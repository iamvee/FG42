;; Functions -------------------------------------------------

;;;###autoload
(defun js2-careless-semicolon ()
  "Don't give a shit about semicolons. According to javascript's bullshit standard."
  (interactive)
  (setq js2-strict-missing-semi-warning nil)
  (js2-mode))

;;;###autoload
(defun javascript-callback ()
  (require 'jquery-doc)

  (js2-minor-mode t)
  ;; FIXME: don't hard code the indent size
  (setq js2-basic-offset 2)

  (define-key js2-mode-map (kbd "C-c C-d") 'js2-jump-to-definition)

  (require 'company-web-jade)
  (define-key js2-mode-map (kbd "C-'") 'company-web-jade)

  (jquery-doc-setup))

;;;###autoload
(defun extensions/javascript-initialize ()
  "Javascript development plugin initialization."

  (ability indium ()
           (defun init-indium ()
             (interactive)
             (require 'indium))
           (add-hook 'js2-mode-hook #'init-indium)
                                        ;(add-hook 'js2-mode-hook #'jade-interaction-mode)
	   )

  (ability js-complition ()
           (require 'ac-js2)
           (add-to-list 'company-backends 'ac-js2-company))

  (with-ability pug-editor ()
                "Pug template editor."
                (setq pug-tab-width 2)
                (add-to-list 'auto-mode-alist '("\\.pug\\'" . (lambda ()
                                                                (require 'pug-mode)
                                                                (pug-mode)
                                                                (setq pug-tab-width 2)))))

  (ability javascript-editor ('flycheck)
           "Gives FG42 the ability to edit javascript."

           (autoload 'js2-mode "js2-mode" "Javascript mode")
                                        ;(autoload 'tern-mode "tern.el" nil t)

           (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
                                        ;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
           (add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))

           (add-hook 'js2-mode-hook 'javascript-callback)

           (setq js2-highlight-level 3)

           (require 'smart-forward)
           (global-set-key (kbd "M-<up>") 'smart-up)
           (global-set-key (kbd "M-<down>") 'smart-down)
           (global-set-key (kbd "M-<left>") 'smart-backward)
           (global-set-key (kbd "M-<right>") 'smart-forward))

  (ability coffee-editor ()
           "Gives FG42 ability to edit coffee script files."
           (custom-set-variables '(coffee-tab-width 2)))
  (message "'javascript' extension has been initialized."))

(provide 'extensions/javascript/init)
