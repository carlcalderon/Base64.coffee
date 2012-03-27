###
Base64 encode / decode
Author: Carl Calderon (carl.calderon[at]gmail[dot]com)
Inspired by http://www.webtoolkit.info/javascript-base64.html
###

@Base64 = (->

  # Character map
  charMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
  fromCharCode = String.fromCharCode
  encode = @btoa || (input) ->

    input = _utf8_encode input
    output = ""
    i = 0

    while i < input.length

      chr1 = input.charCodeAt(i++)
      chr2 = input.charCodeAt(i++)
      chr3 = input.charCodeAt(i++)

      enc1 = chr1 >> 2
      enc2 = ((chr1 & 3) << 4) | (chr2 >> 4)
      enc3 = ((chr2 & 15) << 2) | (chr3 >> 6)
      enc4 = chr3 & 63

      if isNaN chr2 then enc3 = enc4 = 64
      else if isNaN chr3 then enc4 = 64

      for char in [ enc1, enc2, enc3, enc4 ]
        output += charMap.charAt char

    output

  decode = @atob || (input) ->

    input = input.replace /[^A-Za-z0-9\+\/\=]/g, ""
    i = 0
    output = ""

    while i < input.length

      enc1 = charMap.indexOf input.charAt i++
      enc2 = charMap.indexOf input.charAt i++
      enc3 = charMap.indexOf input.charAt i++
      enc4 = charMap.indexOf input.charAt i++

      chr1 = (enc1 << 2) | (enc2 >> 4)
      chr2 = ((enc2 & 15) << 4) | (enc3 >> 2)
      chr3 = ((enc3 & 3) << 6) | enc4

      output = output + fromCharCode chr1

      if enc3 != 64 then output += fromCharCode chr2
      if enc4 != 64 then output += fromCharCode chr3

    _utf8_decode output;

  _utf8_encode = (string) ->

    out = ""

    # normalize new lines
    string = string.replace /\r\n/g, "\n"

    for i,index in string

      code = string.charCodeAt index

      if code < 128
        out += fromCharCode code

      else if code > 127 and code < 2048
        out += fromCharCode (code >> 6) | 192
        out += fromCharCode (code & 63) | 128

      else
        out += fromCharCode (code >> 12) | 224
        out += fromCharCode ((code >> 6) & 63) | 128
        out += fromCharCode (code & 63) | 128

    out

  _utf8_decode = (string) ->

    out = ""
    i = 0
    code1 = code2 = code3 = 0

    until i == string.length

      code1 = string.charCodeAt i

      if code1 < 128
        out += fromCharCode code1
        i++

      else if code1 > 191 && code1 < 224
        code2 = fromCharCode code1 + 1
        out += fromCharCode ((code1 & 31) << 6) | (code2 & 63)
        i += 2

      else
        code2 = string.charCodeAt i + 1
        code3 = string.charCodeAt i + 2
        out += fromCharCode ((code1 & 15) << 12) | ((code2 & 63) << 6) | (code3 & 63)
        i += 3

    out
  encode: (input) -> encode input
  decode: (input) -> decode input
)()