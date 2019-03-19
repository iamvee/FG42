(ns john-titor.github
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require
   [john-titor.github.core :as g]))


(defn notification-command
  [args]
  (g/notifications))
