(ns john-titor.utils
  (:require
   ["bluebird" :as Promise]
   [clojure.core.async :refer [take!]]))

(defn wait-for
  [ch]
  (Promise.
   (fn [resolve]
     ;; Handle the channel timeout here
     (take! ch (fn [value]
                 (resolve (clj->js value)))))))
