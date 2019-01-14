(ns john-titor.utils
  (:require
   [clojure.core.async :refer [take!]]))

(defn wait-for
  [ch]
  (take! ch))
