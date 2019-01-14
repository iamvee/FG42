(ns john-titor.github.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require
   ;; TODO: Remove xhr2 after finishing the lib
   ["xhr2" :as xhr2]
   [cljs-http.client :as http]
   [cljs.core.async :refer [<!]]))

(set! js/XMLHttpRequest xhr2)
(def github-username "lxsameer")
(def token "4e61196d7c72ff19b7aa1a6f6c968654f1d06d44")
(def base-url "https://api.github.com")

(defn default-opts
  [token]
  {:headers
   {"Accept" "application/vnd.github.v3+json"
    "Authorization" (str "token " token)
    "User-Agent" github-username}})

(defn process-response
  [f  ch]
  (go (f (<! ch))))

(defn- api-call
  [f url opts]
  (let [options (merge (default-opts token) opts)]
    (f (str  base-url url) options)))

(defn api-get
  ([url]
   (api-get url {}))
  ([url opts]
   (api-call http/get url options)))

(defn api-post
  [url opts]
  (api-call http/post url options))

(defn notifications
  ([]
   (notifications {}))
  ([opts]
   (api-get "/notifications" {})
   (go `(message "hello"))))

(comment
  (notifications)
  (process-response (fn [res]
                      (println (doseq [x (:body res)]
                                 (println (str (:name (:repository x))
                                               " "
                                               ;;(:title (:subject x))
                                               " "
                                               (:reason x))))))
                    (notifications)))
