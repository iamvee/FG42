;;; dsl --- A dsl to be used with project configurations.
;;; Commentary:
;;; Code:
(defvar open-project-configurations (make-hash-table :test 'equal)
  "This hashmap is responsible for storing project configurations.")

;; DSL -----------------------------------------------------
(defmacro deftask (name &rest body)
  "Create a new task for the project with the given NAME and BODY."
  `(let ((pmap (gethash __project-name__
                        open-project-configurations
                        (make-hash-table :test 'equal))))

     (puthash ,(symbol-name name) (lambda (project-path buffer) ,@body) pmap)
     (puthash __project-name__ pmap open-project-configurations)))

(defmacro run-shell-command (command)
  "Run the given shell COMMAND on the run buffer."
  `(async-shell-command ,command buffer))

;; TASK RUNNERS --------------------------------------------
(defun with-buffer (name action)
  "Create a buffer with the given NAME for the given ACTION."
  (get-buffer-create (format "*%s %s*" name action)))

(defun run-task-buffer (project-name)
  "Create or get the buffer which hold the output of run task.

   The buffer name will contains PROJECT-NAME."
  (with-buffer project-name "run"))

(defun execute-task (project task-name)
  "Run the task for PROJECT with the given TASK-NAME."
  (let* ((project-hash (gethash project open-project-configurations))
         (task         (gethash task-name project-hash))
         (buf          (with-buffer project task-name)))
    (funcall task project buf)))

(defun execute-run-task ()
  "Execute the :run task for the current project."
  (interactive)
  (let ((project (cdr (project-current))))
    (execute-task project "run")))

(provide 'projects/dsl)
;;; dsl  ends here
