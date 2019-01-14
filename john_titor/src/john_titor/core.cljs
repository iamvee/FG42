(ns john-titor.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require
   ["xhr2" :as xhr2]
   ["elrpc" :as epc]
   [john-titor.commands :as commands]))


(set! js/XMLHttpRequest xhr2)

(defn main
  []
  (.then (.startServer epc)
         (fn [server]
           (commands/router server)
           (.wait server))))
