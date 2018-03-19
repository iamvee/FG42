;;; project-configurations --- A small library to load project specific configurations.
;;; Commentary:
;;; Code:
(require 'seq)

(defvar open-project-configurations (make-hash-table)
  "This hashmap is responsible for storing project configurations.")

(defvar project-config-dir "~/.fg42/project-config/"
  "This variable contains the path to the projects global configurations.")

(defun project-name (project)
  "Return the project name of the given PROJECT."
  (car (last (seq-filter
               (lambda (x) (not (equal "" x)))
               (split-string project "/")))))

(defun global-project-config-path (project)
  "Return path of the global project config for the given PROJECT or nil."
  (let ((config-path (format "%s/%s.el"
                             project-config-dir
                             (project-name project))))
    (if (file-exists-p config-path)
        config-path
      nil)))

(defun config-path (project)
  "Return the path of the given PROJECT configuration."
  (let ((in-proj-config     (format "%s.fg42.el" project))
        (global-proj-config (global-project-config-path project)))
    (if (file-exists-p in-proj-config)
        in-proj-config
      global-proj-config)))


(defun load-config-file (config)
  "Load the given CONFIG file."
  (require 'extensions/development/project-dsl)
  (load config))


(defun load-configuration ()
  "Load the configuration for the current project."
  (interactive)
  (let* ((project (cdr (project-current)))
         (config  (config-path project)))
    (if (not (equal nil config))
        (load-config-file config)
      (message "No configuration has been found for current project."))))


(provide 'extensions/development/project-configuration)
;;; project-configuration.el ends here
