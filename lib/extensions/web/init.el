;; Functions -------------------------------------------------
;;;###autoload
(defun web-mode-hook-func ()
  "Hooks for Web mode."
  (with-ability code-completion
                (require 'company-web-html)
                (set (make-local-variable
                      'company-backends) '(company-web-html))

                (define-key web-mode-map (kbd "C-'") 'company-web-html))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (setq web-mode-markup-indent-offset 2))

;;;###autoload
(defun extensions/web-activate-modes ()
  "Activate necessary modes"
  (setq css-indent-offset 2)
  
  (with-ability rainbow
                (rainbow-mode t))

  (with-ability spell
                (flyspell-prog-mode))

  (with-ability flycheck
                (flycheck-mode t)))


;;;###autoload
(defun extensions/web-initialize ()
  "Web development plugin initialization."
  (message "Initializing 'web' extension.")

  (ability web-editor ('flycheck)
           "Gives FG42 the ability to edit web contents."
           (require 'web-mode)

           (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.handlebars\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
           (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))


           (add-hook 'web-mode-hook 'web-mode-hook-func)
           (add-hook 'web-mode-hook 'emmet-mode)
           (add-hook 'web-mode-hook 'extensions/web-activate-modes))

  (ability css-editor
           "Gives FG42 the ability to edit CSS."
           (add-hook 'css-mode-hook 'extensions/web-activate-modes))

  (ability sass-editor
           "Gives FG42 the ability to edit SASS/SCSS."

           (add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
           (add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

           (setq scss-compile-at-save nil)
           (setq sass-compile-at-save nil)

           (add-hook 'scss-mode-hook 'extensions/web-activate-modes)
           (add-hook 'sass-mode-hook 'extensions/web-activate-modes))

  (ability less-editor
           "Gives FG42 the ability to edit lesscss."
           (add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))
           (add-hook 'less-css-mode-hook 'extensions/web-activate-modes))

  (ability js-editor
           "Gives FG42 the ability to edit Javascript."
           (add-hook 'js2-mode-hook 'extensions/web-activate-modes)
           (add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
           (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))



(provide 'extensions/web/init)
