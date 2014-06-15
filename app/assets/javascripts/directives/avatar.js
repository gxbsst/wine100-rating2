APP.directive('avatar', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            var src = attrs.src || attrs.ngSrc,
                type = attrs.type || 'user',
                def = {
                    user:'/avatar/green.jpg',
                    group:'/avatar/group.jpg'
                }[type],
                img = new Image(),
                avatar;
            if(!src){
                src = def;
            }
            img.onerror = function () {
                src = def;
                element.replaceWith(angular.element('<img src="'+src+'" />'));
            };
            img.onload = function () {
                avatar = angular.element('<img src="'+src+'" />');
                element.replaceWith(avatar);
                var image = $('img',avatar),scale;
                if(this.width > this.height){
                    image.attr({height:'100%'});
                    image.css({marginLeft:-(image.width()-image.height())/2});
                }else{
                    $('img',avatar).attr({width:'100%'});
                }
            };
            img.src = src;
        }
    };
});
