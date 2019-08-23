;;; json --- FG42 json helpers
;;
;; Copyright (c) 2019  Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Keywords: webkit
;; Version: 0.1.0
;; Package-Requires: ((dash "2.11.0") (websocket "1.5"))
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
;;; Acknoledgement:
;; This library is heavily inspired by Kite mini library. Kudos Tung Dao
;; for his great work.
;;
;;; Commentary:
;;; Code:

(require 'json)


(defun ->json (data)
  "Convert the given DATA to json."
  (let ((json-array-type 'list)
        (json-object-type 'plist))
    (json-encode data)))


(defun <-json (data)
  "Convert the given json DATA to elisp data structure."
  (let ((json-array-type 'list)
        (json-object-type 'plist))
    (json-read-from-string data)))


(provide 'fg42/utils/json)
;;; json.el ends here
