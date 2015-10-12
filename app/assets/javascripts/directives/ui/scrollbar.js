APP.directive('scrollConfig', function ($window, $document) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var config = eval('({' + (attrs.scrollConfig||'') + '})'),
                id = attrs.id || 'scroll' + (+new Date());
            $.scrollBar[id] = $(element).attr('id', id).scrollBar(config);
        }
    };
});