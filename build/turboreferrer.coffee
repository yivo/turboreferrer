###!
# turboreferrer 1.0.3 | https://github.com/yivo/turboreferrer | MIT License
###

Turbolinks.referrer = document.referrer

if Turbolinks.supported

  # Sometimes history.state is not defined.
  # Note: we are using || comparison to catch all possible falsy values.
  unless history.state
    # Let browser to define history.state.
    history.replaceState url: location.href, '', location.href

    # If it doesn't help force define state object.
    history.state ||= url: location.href

  history.state.referrer = document.referrer
  
  history.pushState = do ({pushState} = history) ->
    (pushedState) ->
      pushedState.referrer = history.state.url
      returned             = pushState.apply(history, arguments)
      Turbolinks.referrer  = pushedState.referrer
      returned
      
  window.addEventListener 'popstate', ({state: poppedState}) ->
    Turbolinks.referrer = poppedState?.referrer ? document.referrer
