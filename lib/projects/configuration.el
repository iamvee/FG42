;;; configurations --- A small library to load project specific configurations.
;;; Commentary:
;;; Code:
(require 'seq)

(defvar project-config-dir "~/.fg42/project-config/"
  "This variable contains the path to the projects global configurations.")

(defvar __project-name__ nil
  "It's an internal variable to holds the current project name.")

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


(defun load-config-file (project-name config)
  "Load the given CONFIG file with the given PROJECT-NAME."
  (require 'projects/dsl)
  (setq __project-name__ project-name)
  (load config))


(defun load-configuration ()
  "Load the configuration for the current project."
  (interactive)
  (let* ((project (cdr (project-current)))
         (config  (config-path project)))
    (if (not (equal nil config))
        (load-config-file project config)
      (message "No configuration has been found for current project."))))


(provide 'projects/configuration)
;;; configuration.el ends here
