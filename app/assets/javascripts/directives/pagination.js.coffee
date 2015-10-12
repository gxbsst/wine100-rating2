APP.directive('pagination', ->
  restrict: 'E'
  templateUrl: '/assets/directives/pagination.html'

  link: (scope, element, attrs) ->
    config = scope.$eval(attrs.config)
    scope.incPage = (num) ->
      page = scope.page + num
      return false if page > config.totalPage || page < 1
      scope.page = page
)