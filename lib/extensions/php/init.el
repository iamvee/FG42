;; Functions ----------------------------------

(defun extensions/php-initialize ()
  "PHP extensions initialization function"
  (add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
  )

(provide 'extensions/php/init)
