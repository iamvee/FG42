
(ns john-titor.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require
   ["xhr2" :as xhr2]
   [cljs-http.client :as http]
   [cljs.core.async :refer [<!]]))

(set! js/XMLHttpRequest xhr2)

(defn main
  [])
