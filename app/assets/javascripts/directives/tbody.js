APP.directive('tbody', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            element.on('mouseenter', 'tr',function () {
                $(this).addClass('mouseenter');
            }).on('mouseleave', 'tr', function () {
                    $(this).removeClass('mouseenter');
                });
        }
    };
});
