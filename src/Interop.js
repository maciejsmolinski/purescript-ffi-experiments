'use strict';

exports.message = 'Hello from JS!';

exports.greet = function(suffix) {
  return 'Hello ' + suffix;
};

exports.user = {
  name: 'JavaScriptOne'
};

exports.render = function(msg) {
  return function() {
    document.querySelector('#ps-purs-ffi').textContent = msg;
  };
};
