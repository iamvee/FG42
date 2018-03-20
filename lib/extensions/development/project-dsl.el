;;; project-dsl --- A dsl to be used with project configurations.
;;; Commentary:
;;; Code:
(defvar open-project-configurations (make-hash-table :test 'equal)
  "This hashmap is responsible for storing project configurations.")

(defmacro run (body)
  "It's going to run the given BODY when user wanted to run the project."
  `(let ((pmap (gethash __project-name__
                        open-project-configurations
                        (make-hash-table :test 'equal))))

     (puthash :run (lambda () ,body) pmap)
     (puthash __project-name__ pmap open-project-configurations)))

(provide 'extensions/development/project-dsl)
;;; project-dsl  ends here
