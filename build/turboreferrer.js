
/*!
 * turboreferrer 1.0.3 | https://github.com/yivo/turboreferrer | MIT License
 */

(function() {
  Turbolinks.referrer = document.referrer;

  if (Turbolinks.supported) {
    if (!history.state) {
      history.replaceState({
        url: location.href
      }, '', location.href);
      history.state || (history.state = {
        url: location.href
      });
    }
    history.state.referrer = document.referrer;
    history.pushState = (function(arg) {
      var pushState;
      pushState = arg.pushState;
      return function(pushedState) {
        var returned;
        pushedState.referrer = history.state.url;
        returned = pushState.apply(history, arguments);
        Turbolinks.referrer = pushedState.referrer;
        return returned;
      };
    })(history);
    window.addEventListener('popstate', function(arg) {
      var poppedState, ref;
      poppedState = arg.state;
      return Turbolinks.referrer = (ref = poppedState != null ? poppedState.referrer : void 0) != null ? ref : document.referrer;
    });
  }

}).call(this);
