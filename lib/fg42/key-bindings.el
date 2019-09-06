;;; fg42-keybindings --- Keybinding helper macros for FG42
;;
;; Copyright (c) 2019  Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Keywords: keybinding
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
;;; Commentary:
;;; Code:

(defmacro defkey (docstring map key-map fn)
  "Defines a key binding for FG42 for different types.
Defines a keybinding in the given MAP for the given KEY-MAP that maps
to the given FN with the given DOCSTRING.

KEY-MAP should be a plist in the following format:
\(:god <keyma> :human <keymap> :evil <keymap)")

(provide 'fg42/key-bindings)
;;; key-bindings.el ends here
