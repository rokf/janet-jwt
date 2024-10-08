# janet-jwt

A JWT library for Janet.

## Installation

You can install it directly using `jpm`

```
jpm install https://github.com/rokf/janet-jwt
```

or by adding it into your project's dependency tuple

```
(declare-project
  :dependencies [
    { :url "https://github.com/rokf/janet-jwt" :tag "main" }
  ])
```

## API

The `jwt` module that is part of this library exposes three functions:

- `encode`
- `decode`
- `verify`

### `jwt/encode`

The `encode` function expects a table or struct, which will represent the token's
claims (payload object). Optionally you can also pass it a signing algorithm
identifier (keyword or string) and a function that implements that signing algorithm.

The signing function is expected to take a string (`{header}.{payload}`) and return a
string (the generated signature).

The algorithm will default to `:none` if not specified. If the algorithm identifier
is not `nil` or `:none` then the signing function must be provided as well.

The `encode` function will return an encoded and signed JWT token (string).

### `jwt/decode`

@TODO

### `jwt/verify`

@TODO

## License

MIT - see the `LICENSE` file at the root of the repository for details.
