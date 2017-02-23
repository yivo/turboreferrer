###!
# turboreferrer 1.0.2 | https://github.com/yivo/turboreferrer | MIT License  
###

Turbolinks.referrer = document.referrer

if Turbolinks.supported
  unless history.state?
    history.replaceState url: location.href, '', location.href
    
  history.state.referrer = document.referrer
  
  history.pushState = do ({pushState} = history) ->
    (pushedState) ->
      pushedState.referrer = history.state.url
      returned             = pushState.apply(history, arguments)
      Turbolinks.referrer  = pushedState.referrer
      returned
      
  window.addEventListener 'popstate', ({state: poppedState}) ->
    Turbolinks.referrer = poppedState?.referrer ? document.referrer
