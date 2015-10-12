APP.directive('img', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            if (attrs.exception == undefined) {
                element.attr({src: '/images/blank.gif'}).addClass('loadingImage');
                var src = attrs.src || attrs.ngSrc,
                    width = parseInt(attrs.maxWidth || 600, 10),
                    height = attrs.maxHeight,
                    img = new Image();
                img.onerror = function () {
                    element.addClass('loadingImage');
                };
                img.onload = function () {
                    if (width && height) {
                        height = parseInt(attrs.maxHeight, 10);
                        var scale;
                        if (this.width > this.height) {
                            scale = height / this.height;
                            width = this.width * scale;
                            element.attr({height: height, width:width}).css({marginLeft:-(width-height)/2});
                        }else{
                            scale = width / this.width;
                            height = this.height * scale;
                            element.attr({width: width, height: height}).css({marginTop:-(height-width)/2});
                        }
                    }else if(this.width > width){
                        element.attr({width: width});
                    }
                    element.removeClass('loadingImage').attr({src: src});
                };
                img.src = src;
            }
        }
    };
});
