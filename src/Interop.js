'use strict';

exports.render = function(msg) {
  return function() {
    document.querySelector('#ps-purs-ffi').textContent = msg;
  };
};
