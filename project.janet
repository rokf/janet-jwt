(declare-project
  :name "janet-jwt"
  :author "Rok Fajfar <hi@rokf.dev>"
  :description "A JWT library for Janet"
  :license "MIT"
  :version "0.0.1"
  :url "https://github.com/rokf/janet-jwt"
  :repo "git+https://github.com/rokf/janet-jwt"
  :dependencies ["spork"])

(declare-source
  :prefix "jwt"
  :source ["src/init.janet"])
