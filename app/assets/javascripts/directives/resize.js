APP.directive('modalDialog', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            scope.$watch(function () {
                element.css({marginLeft:-(element.width()/2),marginTop:-(element.height()/2)});
            });
        }
    };
});