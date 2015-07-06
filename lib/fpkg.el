;;; fpkg --- a simple package manager for FG42                     -*- lexical-binding: t; -*-

;; Copyright (C) 2015  lxsameer

;; Author: Nic Ferrier <lxsameer@gnu.org>
;; Keywords: lisp fg42 IDE package manager
;; Version: 1.0.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Simple package manager for FG42

;;; Code:
(require 'cl-lib)

(message "Initializing FPKG")

;; Variables ---------------------------------
(cl-defstruct fpkg-dependency
  "Package structure for FG42."
  name
  (version "0")
  (github nil)
  (path nil))

(defvar required-packages (make-hash-table)
  "A hash of `fg42-package structure representing required packages.")

;; Functions ----------------------------------
(defun fpkg-initialize ()
  "Initilize the package.el and related stuff to be used in FG42"

  )

(defun depends-on (pkgname &rest args)
  "Global function to specify a single dependency"
  (let ((pkg (apply 'make-fpkg-dependency :name pkgname args)))
    (puthash pkgname pkg  required-packages)))
 
(provide 'fpkg)
