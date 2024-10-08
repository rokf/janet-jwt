(use judge)
(import ../src :prefix "jwt/")

(test (jwt/encode {:name "Rok"}) "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJuYW1lIjoiUm9rIn0.")

(test (jwt/decode "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJuYW1lIjoiUm9rIn0.")
      {:header @{:alg "none" :typ "JWT"}
       :payload @{:name "Rok"}})

(test (jwt/verify "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJuYW1lIjoiUm9rIn0.") true)

(test (jwt/encode {:name "Rok"} "mocked" (fn [hp] "mocked")) "eyJhbGciOiJtb2NrZWQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiUm9rIn0.mocked")

(test (jwt/decode "eyJhbGciOiJtb2NrZWQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiUm9rIn0.mocked")
      {:header @{:alg "mocked" :typ "JWT"}
       :payload @{:name "Rok"}})

(test (jwt/verify "eyJhbGciOiJtb2NrZWQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiUm9rIn0.mocked" (fn [sig] (= sig "mocked"))) true)
