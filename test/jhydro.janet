(use judge)

# https://github.com/janet-lang/jhydro
(import jhydro)

(import ../src :prefix "jwt/")

(import ./base64url)

(def ctx "janetjwt")

(def {:public-key pub :secret-key sec} (jhydro/sign/keygen))

(def payload {:name "Rok"})

# The base64 URL encoding here is required because jhydro's signature algorithm occasionally
# produces output with dots, which broke the signature extraction part of the implementation.
(def encoded (jwt/encode payload "jhydro" (fn [hp] (base64url/encode (jhydro/sign/create hp ctx sec)))))

(test (jwt/verify encoded (fn [sig hp] (jhydro/sign/verify (base64url/decode sig) hp ctx pub))) true)

(def {:header header :payload payload} (jwt/decode encoded))

(test (get header :alg) "jhydro")

(test (get payload :name) "Rok")
