(import spork/json)
(import spork/base64)

(defn- encode-struct [s]
  (->>
    (base64/encode (string (json/encode s)))
    (string/replace-all "+" "-")
    (string/replace-all "/" "_")
    (string/replace-all "=" "")))

(defn- decode-string [s]
  (json/decode (->>
                 (string s (string/repeat "=" (- 4 (% (length s) 4))))
                 (string/replace-all "_" "/")
                 (string/replace-all "-" "+")
                 (base64/decode)) true))

(defn- get-sig-fn [alg custom-fn]
  (if (= alg :none) (fn [&] "") custom-fn))

(defn encode
  "Produces an encoded JWT (JWS if unsigned)."
  [claims &opt alg signature-fn]
  (default alg :none)
  (let [header (encode-struct {:alg alg :typ "JWT"})
        payload (encode-struct claims)
        header-and-payload (string header "." payload)
        signature ((get-sig-fn alg signature-fn) header-and-payload)] (string header-and-payload "." signature)))

(defn decode
  "Decodes a JWT, returning its header and payload. Does not do any validation."
  [encoded]
  (let [parts (string/split "." encoded)
        header (decode-string (in parts 0))
        payload (decode-string (in parts 1))]
    {:header header :payload payload}))

(defn verify
  "Verifies the JWT's signature. Returns true if valid, false otherwise."
  [encoded &opt verify-fn]
  (let [parts (string/split "." encoded)
        header (decode-string (in parts 0))
        signature (in parts 2)]
    (if (= verify-fn nil) (and (= (get header :alg) "none") (= signature "")) (verify-fn signature (string (in parts 0) "." (in parts 1))))))
