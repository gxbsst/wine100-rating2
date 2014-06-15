APP.directive('datepicker', function () {
    return {
        restrict: 'E',
        transclude: true,
        link: function (scope, element, attrs) {
            var config = {};
            if (attrs.config) {
                config = eval('({' + attrs.config + '})');
            }
            element.pikaday(config);
        },
        template: '<input type="text" class="datepicker" ng-transclude/>',
        replace: true
    };
});