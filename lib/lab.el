(defun add-debug-js ()
  (interactive)
  (insert (concat "console.log('" (which-function) ": ', );"))
  (goto-char (- (point) 2)))

(defun add-debug-py ()
  (interactive)
  (insert (concat "print('" (which-function) ": ', )"))
  (goto-char (- (point) 1)))

(defun insert-printer ()
  (interactive)
  (cond
   ((member (buffer-mode (current-buffer)) '(rjsx-mode js2-mode)) (add-debug-js))
   ((member (buffer-mode (current-buffer)) '(python-mode)) (add-debug-py))))

(global-set-key (kbd "M-2") 'insert-printer)
