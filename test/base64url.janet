(import spork/base64)

(defn encode
  "Encode the input (i) with base64 URL encoding."
  [i]
  (->>
    (base64/encode i)
    (string/replace-all "+" "-")
    (string/replace-all "/" "_")
    (string/replace-all "=" "")))

(defn decode
  "Decode a base64 URL encoded input string (i)."
  [i]
  (->>
    (string i (string/repeat "=" (- 4 (% (length i) 4))))
    (string/replace-all "_" "/")
    (string/replace-all "-" "+")
    (base64/decode)))
