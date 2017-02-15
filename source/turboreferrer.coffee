###!
# turboreferrer 1.0.1 | https://github.com/yivo/turboreferrer | MIT License  
###
  
Turbolinks.referrer = document.referrer

if Turbolinks.supported
  history.state.referrer = document.referrer
  
  history.pushState = do ({pushState} = history) ->
    (pushedState) ->
      pushedState.referrer = history.state.url
      returned             = pushState.apply(history, arguments)
      Turbolinks.referrer  = pushedState.referrer
      returned
      
  window.addEventListener 'popstate', ({state: poppedState}) ->
    Turbolinks.referrer = poppedState?.referrer ? document.referrer
