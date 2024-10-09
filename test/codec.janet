# https://github.com/joy-framework/codec
(import codec)

(import ../src :prefix "jwt/")

(use judge)

(def payload {:hello "World"})
(def secret "very-secret-123")

(def encoded (jwt/encode payload "HS256" (fn [hp] (codec/hmac/sha256 secret hp))))

(test (jwt/verify encoded (fn [sig hp] (= sig (codec/hmac/sha256 secret hp)))) true)

(def {:header header :payload payload} (jwt/decode encoded))

(test (get header :alg) "HS256")

(test (get payload :hello) "World")
