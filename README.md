# Base64.coffee

Fresh brew of Base64 coffee. Uses `btoa` and `atob` if available.

## Usage

	# Encoding
	Base64.encode "Hello World" # output: SGVsbG8gV29ybGQ=

	# Decoding
	Base64.decode "SGVsbG8gV29ybGQ=" # output: Hello World
