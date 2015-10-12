APP
    .directive('tabs', function () {
        return {
            restrict: 'E',
            transclude: true,
            replace: true,
            controller: function ($scope, $element) {
                var panes = $scope.panes = [];
                $scope.select = function (pane) {
                    angular.forEach(panes, function (pane) {
                        pane.selected = false;
                    });
                    pane.selected = true;
                };
                this.addPane = function (pane) {
                    if (panes.length == 0) $scope.select(pane);
                    panes.push(pane);
                }
            },
            template: '<div class="tabs">' +
                '<ul class="tabs-nav">' +
                '<li ng-repeat="pane in panes" ng-class="{selected:pane.selected}"><a href="javascript:void(0);" ng-bind-html="pane.tabTitle"></a></li>' +
                '</ul>' +
                '<div class="clear"></div>' +
                '<div class="tab-content" ng-transclude></div>' +
                '</div>'
        };
    })
    .directive('pane', function () {
        return {
            require: '^tabs',
            restrict: 'E',
            transclude: true,
            scope: { tabTitle: '@' },
            link: function(scope, element, attrs, tabsCtrl) {
                scope.src = attrs.src;
                tabsCtrl.addPane(scope);
            },
            template:'<div class="tab-pane" ng-class="{show: selected}" ng-transclude></div>',
            replace: true
        };
    });