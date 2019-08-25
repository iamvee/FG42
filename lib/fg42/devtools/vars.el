;;; fg42-devtools --- Webkit devtool driver for FG42
;;
;; Copyright (c) 2019  Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Keywords: webkit
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
;;; Acknoledgement:
;; This library is heavily inspired by Kite mini library. Kudos Tung Dao
;; for his great work.
;;
;;; Commentary:
;;; Code:

;;; Customs & Vars ------------------------------------------------------------
(defcustom fg42/devtools-remote-host "127.0.0.1"
  "Default host for connection to WebKit remote debugging API."
  :group 'fg42/devtools)


(defcustom fg42/devtools-remote-port 9222
  "Default port for connection to WebKit remote debugging API."
  :group 'fg42/devtools)


(defvar fg42/devtools-socket nil
  "Websocket connection to WebKit remote debugging API.")


(defvar fg42/devtools-rpc-id 0)


(defvar fg42/devtools-rpc-callbacks nil)


(defvar fg42/devtools-rpc-scripts nil
  "List of JavaScript files available for live editing.")

(defvar fg42/devtools-console-buffer-name "*1-console*")
(defvar fg42/devtools-network-buffer-name "*2-network*")

(provide 'fg42/devtools/vars)
;;; vars.el ends here
