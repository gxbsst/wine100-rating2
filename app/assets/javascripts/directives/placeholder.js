APP.directive('placeholder', function ($timeout) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var wait = function(){
                $timeout(function(){
                    if(!/^\{\{LANG/.test($(element).val())&&!/\.\.\./.test($(element).val())){
                        element.is(':visible') && $(element).placeHolder();
                    }else{
                        wait();
                    }
                },20);
            };
            if($.IE && $.IE < 10 && attrs.placeholder){
                wait();
            }
        }
    }
});
