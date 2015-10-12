APP.directive('input', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            var self = $(element);
            attrs.type != 'hidden' && self.addClass(attrs.type);
        }
    };
});