;;; project-manager --- Extends the support for project base functionalities
;;
;; Copyright (C) 2010-2020 Sameer Rahmani <lxsameer@gnu.org>
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; Created: 20 Jan 2020
;; Keywords: project management
;; Homepage: https://fg42.org
;; Version: 0.1.0
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Change Log:

;;; Commentary:

;;; Code:
(require 'projectile)

;; Vars ------------------------
(defvar fg42-default-project-file ".fg42.el"
  "The name of default project file in projects.")

;; Functions -------------------
(defun project-manager/load-file (file-name)
  "Find and load the given FILE-NAME relative to the project root dir."
  (let ((root (projectile-project-root)))
    (load-file (concat (file-name-as-directory root) file-name))))


;; (defmacro define-project ()
;;     `(defun ,(projectile-project-name)))

(provide 'project-manager)
;;; project-manager.el ends here
