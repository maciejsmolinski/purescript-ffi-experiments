'use strict';

exports.render = function(msg) {
  return function() {
    var target = document.querySelector('#ps-purs-ffi');

    if (target) {
      target.textContent = msg;
    }
  };
};

exports.append = function(msg) {
  return function() {
    var template = document.querySelector('#ps-purs-ffi');
    var target = template.cloneNode();

    target.textContent = msg;
    template.parentElement.appendChild(target);
  };
};

exports.succeed = function(onSuccess) {
  return function(onFailure) {
    return function() {
      Promise.resolve('Success')
        .then(function(value) {
          onSuccess(value)();
        })
        .catch(function(error) {
          onFailure(error)();
        });
    };
  };
};

exports.fail = function(onSuccess) {
  return function(onFailure) {
    return function() {
      Promise.reject('Failure')
        .then(function(value) {
          onSuccess(value)();
        })
        .catch(function(error) {
          onFailure(error)();
        });
    };
  };
};
