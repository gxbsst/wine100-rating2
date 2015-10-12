APP.directive('select', function ($timeout) {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            //$(element).uiSelect(parseInt((attrs.width || 220), 10));
            var width = attrs.width;
            if (width) {
                element.css({width: parseInt(width, 10) + 2});
            }
            element.wrap('<span class="select-wrap"></span>');
        }
    };
});