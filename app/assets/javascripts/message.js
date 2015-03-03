// $.noty.defaults.timeout = 1000
// $.noty.defaults.layout = 'bottom'

function notyMessage(type,msg) {
  switch (type) {
    case 'alert':
      var notyType = 'error';
      var notyTimeout = 4000;
      break;
    case 'notice':
      var notyType = 'success';
      var notyTimeout = 2500;
      break;
    default:
      var notyType = type;
      var notyTimeout = 3000;
  };
  var n = noty({
    layout: 'topCenter',
    timeout: notyTimeout,
    text: msg,
    type: notyType,
  });
};
