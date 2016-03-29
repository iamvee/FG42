;; Important Note: On linux you need to add your user to 'dialout' group
;; OS reqyurements:  You need to install these utilities:
;; * arduino-mk
;; * python-serial
;; * avrdude
;; * libdevice-serialport-perl
;; * libyaml-perl
;;
;; You need following environments veriables:
;; export ARDUINO_DIR=$HOME/bin/arduino-1.6.8
;; export ARDMK_DIR=/usr/share/arduino
;; export ARDMK_PATH=/usr/bin

;;; Code:
(require 'fpkg)
(require 'fg42/extension)
(require 'extensions/arduino/init)

;; Dependencies ----------------------------------
(depends-on 'arduino-mode)
(depends-on 'company-arduino)
(depends-on 'mustache)

;; Extension -------------------------------------
(extension arduino
	   :version "2.31"
	   :on-initialize extensions/arduino-initialize)

(provide 'extensions/arduino)
;;; arduino.el ends here
