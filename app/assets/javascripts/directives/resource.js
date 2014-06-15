APP.directive('resource', function ($timeout) {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            var resource = eval('({' + attrs.config + '})'),
                isLink = resource.type == 'LinkResource',
                href = isLink ? resource.url : 'javascript:void(0);',
                thumb = isLink ? '<img src="/ico/html.png" />' : '<thumb data-url="' + resource.url + '" data-name="' + resource.name + '" ng-transclude></thumb>',
                a = angular.element('<a href="' + href + '&attchment=' + encodeURIComponent(resource.name) + '" ' + (isLink ? ' target="_blank"' : '') + ' class="attachment resourcePreview" data-id="' + resource.id + '">' +
                    '<span class="thumb">' + thumb + '</span></a>');
            element.replaceWith(a);
            $timeout(function () {
                scope.$apply();
            }, 100);
        }
    };
});
