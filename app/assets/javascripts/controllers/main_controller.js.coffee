APP.controller 'MainController', ($scope, $window, $document, $http) ->

  $scope.hover = {}
  $scope.award_value = {}
  $scope.final_award_value = {}
  $scope.award = (wine_id, award) ->
    $http.post('/awards.json', { wine_id: wine_id, 'award': award})
    .success((data, status, headers, config) ->
      $scope.award_value[wine_id] = data.award
    )
    .error((data, status, headers, config) ->
      alert(status)
    )

  $scope.finalAward = ( wine_id, final) ->
    $http.post('/final_awards.json', { wine_id: wine_id, final: final}, {cache: false})
    .success((data, status, headers, config) ->
      $scope.final_award_value[wine_id] = data.final
    )
    .error((data, status, headers, config) ->
      alert(status)
    )

.controller 'ProgressController', ($scope, $window, $document, $http, $timeout) ->

  $scope.getPercent = ->
    $http.get('/wine_groups/progress.json')
    .success((data, status, headers, config) ->
      $scope.percent = data.percent
    )

  $scope.intervalFunction = ->
    $timeout(
      ->
        $scope.getPercent()
        $scope.intervalFunction()
      ,
      1000
    )

  $scope.intervalFunction()

.controller 'NotifyController', ($scope, $window, $document, $http, $timeout) ->

  $scope.getCompleteCount = ->
    $http.get('/wine_groups.json')
    .success((data, status, headers, config) ->
      $scope.now_complete_count = data.complete_count
    )

  $scope.intervalFunction = ->
    $timeout(
      ->
        $scope.getCompleteCount()
        $scope.intervalFunction()
    ,
      30000
    )

  $scope.intervalFunction()





