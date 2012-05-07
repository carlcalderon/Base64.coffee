
/*!
Base64 encode / decode
Author: Carl Calderon (carl.calderon[at]gmail[dot]com)
Inspired by http://www.webtoolkit.info/javascript-base64.html
*/

(function() {

  this.Base64 = (function() {
    var charMap, decode, encode;
    charMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    encode = this.btoa || function(input) {
      var char, chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, output, _i, _len, _ref;
      output = "";
      i = 0;
      while (i < input.length) {
        chr1 = input.charCodeAt(i++);
        chr2 = input.charCodeAt(i++);
        chr3 = input.charCodeAt(i++);
        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;
        if (isNaN(chr2)) {
          enc3 = enc4 = 64;
        } else if (isNaN(chr3)) {
          enc4 = 64;
        }
        _ref = [enc1, enc2, enc3, enc4];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          char = _ref[_i];
          output += charMap.charAt(char);
        }
      }
      return output;
    };
    decode = this.atob || function(input) {
      var chr1, chr2, chr3, enc1, enc2, enc3, enc4, i, output;
      input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
      i = 0;
      output = "";
      while (i < input.length) {
        enc1 = charMap.indexOf(input.charAt(i++));
        enc2 = charMap.indexOf(input.charAt(i++));
        enc3 = charMap.indexOf(input.charAt(i++));
        enc4 = charMap.indexOf(input.charAt(i++));
        chr1 = (enc1 << 2) | (enc2 >> 4);
        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
        chr3 = ((enc3 & 3) << 6) | enc4;
        output += String.fromCharCode(chr1);
        if (enc3 !== 64) output += String.fromCharCode(chr2);
        if (enc4 !== 64) output += String.fromCharCode(chr3);
      }
      return output;
    };
    return {
      /**
      * Encodes the specified input to Base64.
      * @param {String} input
      * @return {String} result
      */
      encode: function(input) {
        return encode(unescape(encodeURIComponent(input)));
      },
      /**
      * Decodes the specified input from Base64.
      * @param {String} input
      * @return {String} result
      */
      decode: function(input) {
        return decodeURIComponent(escape(decode(input)));
      }
    };
  })();

}).call(this);
