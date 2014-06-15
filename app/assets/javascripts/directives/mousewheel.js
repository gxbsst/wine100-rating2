APP.directive('ngMousewheel', function ($parse) {
    return {
        restrict: 'A',
        compile: function ($element, attr) {
            var fn = $parse(attr.ngMousewheel);
            return function (scope, element, attr) {
                element.on('mousewheel', function (event, delta) {
                    scope.$apply(function () {
                        fn(scope, {$event: event, $delta: delta});
                    });
                });
            };
        }
    };
});