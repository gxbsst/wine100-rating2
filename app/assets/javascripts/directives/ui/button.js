APP.directive('button', function () {
    return {
        restrict: 'EA',
        transclude : true,
        link: function (scope, element, attrs) {
            if(attrs.type=='submit'){
                element.append('<input type="submit" style="display:none;" />');
            }
        },
        template: '<a href="javascript:void(0);" class="button" ng-transclude></a>',
        replace: true
    };
});