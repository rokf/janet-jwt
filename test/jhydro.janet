(use judge)

(import jhydro)

(import ../src :prefix "jwt/")

(def ctx "janetjwt")

(def {:public-key pub :secret-key sec} (jhydro/sign/keygen))

(def payload {:name "Rok"})

(def encoded (jwt/encode payload "jhydro" (fn [hp] (jhydro/sign/create hp ctx sec))))

(test (jwt/verify encoded (fn [sig hp] (jhydro/sign/verify sig hp ctx pub))) true)

(def {:header header :payload payload} (jwt/decode encoded))

(test (get header :alg) "jhydro")

(test (get payload :name) "Rok")
