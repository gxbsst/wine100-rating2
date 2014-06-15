APP.directive('token', function () {
    return {
        restrict: 'E',
        transclude : true,
        template: '<input type="hidden" name="authenticity_token" value="{{token}}">',
        replace: true
    };
});