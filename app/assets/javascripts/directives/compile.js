APP.directive('ngCompile', function ($compile) {
    return function(scope, element, attrs) {
        scope.$watch(
            function(scope) {
                return scope.$eval(attrs.ngCompile);
            },
            function(value) {
                value = value || '';
                element.html(value.replace(/\s?(ng\-.+?=".+?"|ajax|ajax=".+?"|ckedit|ckedit=".+?"|dialog\-config=".+?"|upload\-config=".+?")/gi,''));
                $compile(element.contents())(scope);
            }
        );
    };
});
