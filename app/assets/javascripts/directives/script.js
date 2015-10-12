APP.directive('ngScript', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            angular.element('<script type="text/javascript" src="' + attrs.ngScript + '"></script>').appendTo(element);
        }
    };
});
