(ns john-titor.utils
  (:require
   [clojure.core.async :refer [take! <!!]]))

(defn on-value
  [ch]
  (<!! ch))
