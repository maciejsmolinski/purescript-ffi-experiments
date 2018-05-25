"use strict";

exports.message = "Hello from JS!";

exports.greet = function(suffix) {
  return "Hello " + suffix;
};

exports.user = {
  name: "JavaScriptOne"
};

exports.render = function(msg) {
  return function() {
    if (typeof window !== "undefined") {
      window.document.getElementById("ps-app").innerHTML = msg;
    }
  };
};
