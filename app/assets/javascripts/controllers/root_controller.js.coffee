APP.controller 'RootController', ($scope, $rootScope, Users) ->

    Users.get (user) ->
      $rootScope.current_user = user
      console.log($rootScope.current_user._id)

    APP.ROOT = $rootScope
    APP.Root = $scope
    APP.locale = $rootScope.locale = $.query('locale') || $.cookie('locale') || navigator.systemLanguage || navigator.language || 'en-US'
    APP.locale = APP.locale.split('-')

    APP.ASSETS_ROOT = '/assets'

    if APP.locale[1]
        APP.locale[1] = APP.locale[1].toUpperCase()

    APP.locale = APP.locale.join('-')
    $.cookie('locale', APP.locale, {expires: 7, path: '/'})
    APP.locale = APP.locale.toLowerCase()

    $rootScope.back = -> window.history.back()

    $.ajax({
      url: '/lang/' + APP.locale + '.json'
      type: 'GET'
      dataType: 'json'
      success: (data) ->
        $scope.$apply( -> APP.LANG = $scope.LANG = data )
      error: ->
        $.getJSON '/lang/en-us.json', (data) ->
          $scope.$apply( -> APP.LANG = $scope.LANG = data )
    })
