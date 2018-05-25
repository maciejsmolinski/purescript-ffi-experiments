'use strict';

exports.render = function(msg) {
  return function() {
    var target = document.querySelector('#ps-purs-ffi');

    if (target) {
      target.textContent = msg;
    }
  };
};
