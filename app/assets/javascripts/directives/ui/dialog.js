APP.directive('dialogConfig', function (Dialog) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            element.on('click', function () {
                var config = scope.config = eval('({' + (attrs.dialogConfig || '') + '})'),
                    defaults = {
                        title: element.text() || 'Window'
                    };
                config = angular.extend(defaults, config);
                Dialog(config);
            });
        }
    };
});
