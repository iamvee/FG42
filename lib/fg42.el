;;; FG42 --- a simple package manager for FG42                     -*- lexical-binding: t; -*-

;; Copyright (C) 2015  lxsameer

;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; Keywords: lisp fg42 IDE package manager
;; Version: 2.31

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

;; An Editor/IDE bundle base on Lovely Gnu/Emacs to make your life easier

;;; Code:
(require 'fpkg)
(require 'fg42/base)
(require 'fg42/splash)

(defvar fg42-home (getenv "FG42_HOME")
  "The pass to fg42-home")

(defun fg42-initialize ()
  "Initialize FG42 editor."
  (setq package-user-dir (concat fg42-home "/packages"))
  (fpkg-initialize)
  (initialize-extensions))

(provide 'fg42)
