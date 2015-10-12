APP.directive('thumb', function () {
    return {
        restrict: 'E',
        link: function (scope, element, attrs) {
            var name = (attrs.dataName || attrs.name).toLowerCase(),
                type = name.replace(/.*\.([a-z0-9]+)$/i, '$1'),
                src = attrs.dataUrl || attrs.url,
                size = parseInt((attrs.dataSize || attrs.size || 160), 10),
                img = new Image(),
                thumb;
            if (!/\.(jpg|jpeg|gif|png|bmp|cur)$/.test(name)) {
                src = '/ico/' + type + '.png';
            }
            img.onerror = function () {
                src = '/ico/unknow.png';
                thumb = angular.element('<img src="' + src + '" />');
                thumb.css({marginTop: -24, marginLeft: -24});
                element.replaceWith(thumb.attr('src', src));
            };
            img.onload = function () {
                thumb = $('<img src="' + src + '" />');
                if (this.width > size || this.height > size) {
                    if (this.width > this.height) {
                        thumb.attr('width', size).css({marginTop: -((size / this.width) * this.height / 2), marginLeft: -(size / 2)});
                    } else {
                        thumb.attr('height', size).css({marginLeft: -((size / this.height) * this.width / 2), marginTop: -(size / 2)});
                    }
                } else {
                    thumb.css({marginLeft: -(this.width / 2), marginTop: -(this.height / 2)})
                }
                $(element).replaceWith(thumb.attr('src', src));
            };
            img.src = src;
        }
    };
});
