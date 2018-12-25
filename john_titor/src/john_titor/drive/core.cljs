(ns john-titor.drive.core
  (:require
   ["googleapis" :rename {google g}]))

(def credentials
  {:client_id  "331195722499-qks1ub5i14lbp562t8tebbrfh2abggug.apps.googleusercontent.com"
   :project_id "fg42-lxsameer-1537002823820"
   :auth_uri   "https://accounts.google.com/o/oauth2/auth"
   :token_uri  "https://www.googleapis.com/oauth2/v3/token"
   :auth_provider_x509_cert_url "https://www.googleapis.com/oauth2/v1/certs"
   :client_secret "vc5Zlqqtz7vlx8I9PQHrtbR9"
   :redirect_uris ["urn:ietf:wg:oauth:2.0:oob" "http://localhost"]})

(defn authorize
  ([credentials]
   (authorize credentials nil))
  ([{:keys [client_secret client_id redirect_uris]} token]
   (let [oauth (g.auth.OAuth2. client_secret client_id (first redirect_uris))]
     (when token
       (.setCredentials oauth token))
     oauth)))
p
(defn upload-file
  [oauth])

(defn download-file
  [oauth])
