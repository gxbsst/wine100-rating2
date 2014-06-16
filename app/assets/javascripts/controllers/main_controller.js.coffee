APP.controller 'MainController', ($scope, $window, $document, $http) ->

  $scope.hover = {}
  $scope.award_value = {}
  $scope.final_award_value = {}
  $scope.final_score = []
  $scope.final_final_score = []
  $scope.final_score_success = []
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

  $scope.doFinalScore = (wine_id, final_score) ->
    if !final_score
      alert('请输入分数!')
      return
    $http.post('/awards/final_score.json', { wine_id: wine_id, final_score: final_score}, {cache: false})
    .success((data, status, headers, config) ->
      $scope.final_score[wine_id] = data.final_score
      $scope.final_score_success[wine_id] = true
    )
    .error((data, status, headers, config) ->
      alert(status)
    )

  $scope.doFinalFinalScore = (wine_id, final_score) ->
    if !final_score
      alert('请输入分数!')
      return
    $http.post('/final_awards/final_final_score.json', { wine_id: wine_id, final_score: final_score}, {cache: false})
    .success((data, status, headers, config) ->
      $scope.final_final_score[wine_id] = data.final_final_score
      $scope.final_score_success[wine_id] = true
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





