;;; Code:

;; Functions -------------------------------------------------

;;;###autoload
(defun create-makefile ()
  "Create the arduino make file in the same directory as the ino file if doesn't exits."
  (let ((makefile (concat (file-name-directory buffer-file-name) "Makefile"))
        (makefile-src (concat fg42-home "/lib/extensions/arduino/Makefile")))
    (if (not (file-exists-p makefile))
        (progn (message "Creating arduino make file")
               (copy-file makefile-src makefile)))))

;;;###autoload
(defun arduino/compilation-finished (buffer result)
  (cond ((string-match "finished" result)
         (bury-buffer "*compilation*")
         (message "Compilation done."))
        (t
         (message "Compilation field."))))

;;;###autoload
(defun arduino/compilation-and-upload-finished (buffer result)
  (cond ((string-match "finished" result)
         (bury-buffer "*compilation*")
         (message "Compilation done.")
         (message "Uploading")
         (arduino/upload))
        (t
         (message "Compilation field."))))

;;;###autoload
(defun arduino/compile ()
  "Compile the current arduino project."
  (interactive)
  (let ((compilation-finish-functions 'arduino/compilation-finished))
  (recompile)))


(defun arduino/upload ()
  (interactive)
  (let ((compile-command "make upload"))
    (recompile)))

;;;###autoload
(defun arduino/compile-and-upload ()
  "Compile and upload the current arduino project."
  (interactive)
  (let ((compilation-finish-functions 'arduino/compilation-and-upload-finished))
    (recompile)))

;;;###autoload
(defun extensions/arduino-initialize ()
  "Arduino development plugin initialization."

  (ability arduino-editor ('flycheck)
           "Gives FG42 the ability to edit arduino related contents."
           (add-hook 'arduino-mode-hook 'create-makefile)
           (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))

           (global-set-key (kbd "C-c c") 'arduino/compile)
           (global-set-key (kbd "C-c u") 'arduino/upload)
           (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t))
  (message "'arduino' extension has been initialized."))


(provide 'extensions/arduino/init)
