###
Base64 encode / decode
Author: Carl Calderon (carl.calderon[at]gmail[dot]com)
Inspired by http://www.webtoolkit.info/javascript-base64.html
###

@Base64 = (->

  # Character map
  charMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

  # Encode
  encode = @btoa || (input) ->

    output = ""
    i = 0

    while i < input.length

      chr1 = input.charCodeAt i++
      chr2 = input.charCodeAt i++
      chr3 = input.charCodeAt i++

      enc1 = chr1 >> 2
      enc2 = ((chr1 & 3) << 4) | (chr2 >> 4)
      enc3 = ((chr2 & 15) << 2) | (chr3 >> 6)
      enc4 = chr3 & 63

      if isNaN chr2 then enc3 = enc4 = 64
      else if isNaN chr3 then enc4 = 64

      for char in [ enc1, enc2, enc3, enc4 ]
        output += charMap.charAt char

    output

  # Decode
  decode = @atob || (input) ->

    # remove invalid chars
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

      output += String.fromCharCode chr1

      if enc3 != 64 then output += String.fromCharCode chr2
      if enc4 != 64 then output += String.fromCharCode chr3

    output

  ###*
  * Encodes the specified input to Base64.
  * @param input {String}
  * @return {String} result
  ###
  encode: (input) -> encode unescape( encodeURIComponent input )

  ###*
  * Decodes the specified input from Base64.
  * @param input {String}
  * @return {String} result
  ###
  decode: (input) -> decodeURIComponent escape( decode input )

)()