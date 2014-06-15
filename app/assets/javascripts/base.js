(function (jQuery) {

    // We override the animation for all of these color styles
    jQuery.each(['backgroundColor', 'borderColor', 'borderBottomColor', 'borderLeftColor', 'borderRightColor', 'borderTopColor', 'color', 'outlineColor'], function (i, attr) {
        jQuery.fx.step[attr] = function (fx) {
            if (fx.state == 0) {
                fx.start = getColor(fx.elem, attr);
                fx.end = getRGB(fx.end);
            }
            fx.elem.style[attr] = "rgb(" + [
                Math.max(Math.min(parseInt((fx.pos * (fx.end[0] - fx.start[0])) + fx.start[0]), 255), 0), Math.max(Math.min(parseInt((fx.pos * (fx.end[1] - fx.start[1])) + fx.start[1]), 255), 0), Math.max(Math.min(parseInt((fx.pos * (fx.end[2] - fx.start[2])) + fx.start[2]), 255), 0)
            ].join(",") + ")";
        }
    });

    // Color Conversion functions from highlightFade
    // By Blair Mitchelmore
    // http://jquery.offput.ca/highlightFade/

    // Parse strings looking for color tuples [255,255,255]
    function getRGB(color) {
        var result;

        // Check if we're already dealing with an array of colors
        if (color && color.constructor == Array && color.length == 3)
            return color;

        // Look for rgb(num,num,num)
        if (result = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(color))
            return [parseInt(result[1]), parseInt(result[2]), parseInt(result[3])];

        // Look for rgb(num%,num%,num%)
        if (result = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(color))
            return [parseFloat(result[1]) * 2.55, parseFloat(result[2]) * 2.55, parseFloat(result[3]) * 2.55];

        // Look for #a0b1c2
        if (result = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(color))
            return [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)];

        // Look for #fff
        if (result = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(color))
            return [parseInt(result[1] + result[1], 16), parseInt(result[2] + result[2], 16), parseInt(result[3] + result[3], 16)];

        // Otherwise, we're most likely dealing with a named color
        return colors[jQuery.trim(color).toLowerCase()];
    }

    function getColor(elem, attr) {
        var color;

        do {
            color = jQuery.curCSS(elem, attr);

            // Keep going until we find an element that has color, or we hit the body
            if (color != '' && color != 'transparent' || jQuery.nodeName(elem, "body"))
                break;

            attr = "backgroundColor";
        } while (elem = elem.parentNode);

        return getRGB(color);
    }

    // Some named colors to work with
    // From Interface by Stefan Petre
    // http://interface.eyecon.ro/

    var colors = {
        aqua:[0, 255, 255],
        azure:[240, 255, 255],
        beige:[245, 245, 220],
        black:[0, 0, 0],
        blue:[0, 0, 255],
        brown:[165, 42, 42],
        cyan:[0, 255, 255],
        darkblue:[0, 0, 139],
        darkcyan:[0, 139, 139],
        darkgrey:[169, 169, 169],
        darkgreen:[0, 100, 0],
        darkkhaki:[189, 183, 107],
        darkmagenta:[139, 0, 139],
        darkolivegreen:[85, 107, 47],
        darkorange:[255, 140, 0],
        darkorchid:[153, 50, 204],
        darkred:[139, 0, 0],
        darksalmon:[233, 150, 122],
        darkviolet:[148, 0, 211],
        fuchsia:[255, 0, 255],
        gold:[255, 215, 0],
        green:[0, 128, 0],
        indigo:[75, 0, 130],
        khaki:[240, 230, 140],
        lightblue:[173, 216, 230],
        lightcyan:[224, 255, 255],
        lightgreen:[144, 238, 144],
        lightgrey:[211, 211, 211],
        lightpink:[255, 182, 193],
        lightyellow:[255, 255, 224],
        lime:[0, 255, 0],
        magenta:[255, 0, 255],
        maroon:[128, 0, 0],
        navy:[0, 0, 128],
        olive:[128, 128, 0],
        orange:[255, 165, 0],
        pink:[255, 192, 203],
        purple:[128, 0, 128],
        violet:[128, 0, 128],
        red:[255, 0, 0],
        silver:[192, 192, 192],
        white:[255, 255, 255],
        yellow:[255, 255, 0]
    };
})($);

(function ($) {

    var types = ['DOMMouseScroll', 'mousewheel'];

    if ($.event.fixHooks) {
        for (var i = types.length; i;) {
            $.event.fixHooks[ types[--i] ] = $.event.mouseHooks;
        }
    }

    $.event.special.mousewheel = {
        setup: function () {
            if (this.addEventListener) {
                for (var i = types.length; i;) {
                    this.addEventListener(types[--i], handler, false);
                }
            } else {
                this.onmousewheel = handler;
            }
        },

        teardown: function () {
            if (this.removeEventListener) {
                for (var i = types.length; i;) {
                    this.removeEventListener(types[--i], handler, false);
                }
            } else {
                this.onmousewheel = null;
            }
        }
    };

    $.fn.extend({
        mousewheel: function (fn) {
            return fn ? this.bind("mousewheel", fn) : this.trigger("mousewheel");
        },

        unmousewheel: function (fn) {
            return this.unbind("mousewheel", fn);
        }
    });


    function handler(event) {
        var orgEvent = event || window.event, args = [].slice.call(arguments, 1), delta = 0, returnValue = true, deltaX = 0, deltaY = 0;
        event = $.event.fix(orgEvent);
        event.type = "mousewheel";

        // Old school scrollwheel delta
        if (orgEvent.wheelDelta) {
            delta = orgEvent.wheelDelta / 120;
        }
        if (orgEvent.detail) {
            delta = -orgEvent.detail / 3;
        }

        // New school multidimensional scroll (touchpads) deltas
        deltaY = delta;

        // Gecko
        if (orgEvent.axis !== undefined && orgEvent.axis === orgEvent.HORIZONTAL_AXIS) {
            deltaY = 0;
            deltaX = -1 * delta;
        }

        // Webkit
        if (orgEvent.wheelDeltaY !== undefined) {
            deltaY = orgEvent.wheelDeltaY / 120;
        }
        if (orgEvent.wheelDeltaX !== undefined) {
            deltaX = -1 * orgEvent.wheelDeltaX / 120;
        }

        args.unshift(event, delta, deltaX, deltaY);

        return ($.event.dispatch || $.event.handle).apply(this, args);
    }

})($);


$.extend({
    IE:function () {
        var v = 3, div = document.createElement('div'), all = div.getElementsByTagName('i');
        while (div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->', all[0]);
        return v > 4 ? v : false;
    }(),
    browser:{
        mozilla:/firefox/.test(navigator.userAgent.toLowerCase()),
        webkit:/webkit/.test(navigator.userAgent.toLowerCase()),
        opera:/opera/.test(navigator.userAgent.toLowerCase()),
        msie:/msie/.test(navigator.userAgent.toLowerCase())
    },
    getFileKey:function (file) {
        if (file.mozFullPath) {
            return file.mozFullPath;
        }
        var key = [];
        key.push(file.name);
        key.push(file.size);
        file.creationdate && key.push(file.creationdate);
        file.modificationdate && key.push(file.modificationdate);
        file.lastModifiedDate && key.push(file.lastModifiedDate);
        return key.join('-');
    }
});

$.extend(Array.prototype, {
    has:function (fn) {
        for (var i = 0; i < this.length; i++) {
            if (fn.call(null, this[i])) return true;
        }
        return false;
    },
    find:function (fn) {
        for (var i = 0; i < this.length; i++) {
            if (fn.call(null, this[i])) return this[i];
        }
        return null;
    },
    query:function (fn) {
        var array = [];
        for (var i = 0; i < this.length; i++) {
            if (fn.call(null, this[i])) array.push(this[i]);
        }
        return array;
    },
    getIndex:function (fn) {
        for (var i = 0; i < this.length; i++) {
            if (fn.call(null, this[i])) return i;
        }
        return -1;
    },
    get:function (fn) {
        for (var i = 0; i < this.length; i++) {
            if (fn.call(null, this[i])) return this[i];
        }
        return null;
    },
    first:function () {
        return this[0];
    },
    last:function (length) {
        return this[this.length - (length || 1)];
    },
    toggle:function(value){
        var index = this.getIndex(function(v){
            return v == value;
        });
        if(index >= 0){
            this.remove(index);
        }else{
            this.push(value);
        }
        return this;
    },
    remove:function (target, keyName) {
        var index;
        if(typeof target == 'number'){
            index = target;
        }else if(typeof target == 'string'){
            index = this.getIndex(function(v){
                return v == target;
            });
        }else if ($.isFunction(target)) {
            index = this.getIndex(target);
        } else if (typeof target == 'object') {
            keyName = keyName || 'id';
            index = this.getIndex(function(o){
                return o[keyName] == target[keyName];
            });
        }
        if (index > -1) {
            this.splice(index, 1);
        }
        return this;
    }
});

$.extend(Number.prototype, {
    fileSize:function () {
        var number = this, unit = ['B', 'KB', 'MB', 'GB'];

    },
    toDate:function (unix) {
        return new Date(this * (unix ? 1000 : 1));
    },
    toByte:function () {
        var size = this, n = ['B', 'KB', 'MB', 'GB', 'TB'];
        for (var i = 0, l = n.length; i < l; i++) {
            if (size > 1024) {
                size /= 1024;
            } else {
                return size.toFixed(0) + ' ' + n[i];
            }
        }
        return size.toFixed(0) + ' TB';
    }
});

$.extend(String.prototype, {
    toDate:function () {
        return new Date(this);
    },
    compile: function (data) {
        return this.replace(/\{(.+?)\}/gi, function () {
            return data[arguments[1]] || '';
        });
    }
});

$.extend(Date.prototype, {
    format:function (str) {
        str = str || (/^zh/.test(APP.locale) ? 'yyyy年MM月dd日' : 'MM/dd/yyyy');
        var o = {
            "M+":this.getMonth() + 1,
            "d+":this.getDate(),
            "h+":this.getHours(),
            "m+":this.getMinutes(),
            "s+":this.getSeconds(),
            "q+":Math.floor((this.getMonth() + 3) / 3),
            "S":this.getMilliseconds(),
            "w":this.getDay()
        };
        if (/(y+)/.test(str))str = str.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o) {
            if (o.hasOwnProperty(k)) {
                if (new RegExp("(" + k + ")").test(str)) {
                    str = str.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
                }
            }
        }
        return str;
    },
    isToday:function(){
        var now = new Date();
        return this.getFullYear() == now.getFullYear() && this.getMonth() == now.getMonth() && this.getDate() == now.getDate();
    }
});

function Submit(e) {
    $(e).closest('form').submit();
}
function Cancel() {
    APP.MapScope.InfoWindow.close();
}
function delPoint(uid) {
    $.ajax({
        url:'/geotables/' + uid,
        type:'DELETE',
        success:function () {
            APP.MapScope.getPoints();
        }
    });
}

$().ready(function () {
    //todo:去掉通知删除第221行即可
    //    if (!/^\/(manage|admins)/.test(window.location.pathname) && (APP.locale == 'zh-cn' || APP.locale == 'zh-CN')) {
    //        $('<div id="browser" style="color:red"><div class="text" style="font-size:36px;">通　知</div><d/iv class="text" style="width:900px;margin:20px auto;font-size:26px;text-align:left;text-indent:2em;">为给大家提供更好的服务和活动的支撑，我们进行机房维护和平台维护，预计本周日重新开放。给大家带来的不便敬请谅解，感谢大家的支持！桥·全球教育共同体</div></div>').appendTo('body');
    //    }
    //alert(navigator.userAgent.toLowerCase())
    var ua = navigator.userAgent.toLowerCase();
    if(/android/.test(ua)){
        $('<div id="browser handheld">' +
            '<div class="text">请安装Android客户端！</div>' +
            '<a href="http://124.205.151.234/android/ctalk.apk">下载安装</a>' +
            '</div>').appendTo('body');
    }else if(/(iphone|ipad|ipod)/.test(ua)){
        $('<div id="browser handheld">' +
            '<div class="text">暂时还未开放iOS版本客户端，请通过电脑访问！</div>' +
            '</div>').appendTo('body');
    }else if(/msie\s+?[6-8]\./i.test(ua)){
        var browser = $('<div class="browser">' +
            '<div><a href="http://124.205.151.234/Chromeframe.msi" class="btn" target="_blank"><i class="icon-download"></i>点击下载并安装</a>您的浏览器不支持HTML5，需要安装插件才能正常使用本站的所有功能！</div>' +
            '<div>' +
            '<a href="http://www.firefox.com.cn/" class="btn firefox" target="_blank">Firefox</a>' +
            '<a href="http://xiazai.zol.com.cn/detail/33/327560.shtml" class="btn chrome" target="_blank">Chrome</a>' +
            '您也可以安装 Chrome 或 Firefox 等支持HTML5的浏览器访问本站。' +
            '</div>' +
            '<a href="javascript:void(0);" class="close"></a>' +
            '</div>').appendTo('body');
        browser.delay(1000).animate({top:0}, 600);
        $('.close',browser).click(function(){
            browser.animate({top:-140}, 600);
        });
    }
    /*$('<div class="loading"></div>').appendTo('body');*/
    //$('<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=FOVIVsKp1WTQRQHzW1jvtD8F"></script>').appendTo('body');
    $(document)
        .on('click', '#footmark', function(){
            var self=$(this),
                map = $('.baidumap');
            map.animate({top:0},800);
        })
        .on('click', '#up', function(){
            var self=$(this),
                map = $('.baidumap');
            map.animate({top:-800},600);
        })
        .on('mousewheel', '.flashPaper', function(event){
            event = event || window.event;
            event.stopPropagation();
            event.preventDefault();
            return false;
        })
        .on('click', 'a[type]',function () {
        var self = $(this), type = self.attr('type');
        if(self.is('.disabled'))return false;
        switch (type) {
            case 'submit':
                self.closest('form').submit();
                break;
            case 'file':
                self.prev('input:file').click();
                break;
        }
        return false;
    }).on('mousedown', '#schoolsList .item',function () {
            var self = $(this), id = self.attr('data-id'), scope = APP.RegisterTeacherScope;
            scope.school.select(id);
            scope.$apply();
            $('#schoolsList').hide();
            return false;
        }).on('mouseenter', '.postItem:not(.hasMask,.pending)',function () {
            $(this).addClass('hover');
        }).on('mouseleave', '.postItem:not(.hasMask,.pending)',function () {
            $(this).removeClass('hover');
        }).on('click', '.sendTo', function (event) {
            event = event || window.event;
            event.stopPropagation();
            $('.sendInput', this).focus();
        })/*
     .on('mousedown', '.sendToItem', function () {
     var self = $(this),
     form = self.closest('form'),
     id = self.attr('data-id'),
     scope = APP[form.attr('scope')];
     scope.select(id);
     scope.$apply();
     $('.sendToList', form).hide();
     return false;
     })
     .on('focusin', '.sendInput', function () {
     var input = $(this),
     box = input.closest('.sendTo').addClass('focused');
     input.trigger('keyup');
     $('.sendToList', box).show();
     })
     .on('focusout', '.sendInput', function () {
     var box = $(this).closest('.sendTo').removeClass('focused');
     $('.sendToList', box).hide();
     })
     .on('focusin', '#schoolInput', function () {
     $('#schoolsList').show();
     })
     .on('keyup', '.sendInput', function () {
     var self = $(this),
     form = self.closest('form'),
     val = self.val(),
     old = self.data('value'),
     scope = APP[form.attr('scope')];
     $('.sendToList', form).show();
     if (old != val  || $('.sendToList a',self).length < 5) {
     self.data('value', val);
     $.getJSON('/user/contacts', $.param({
     keyword: val || '.',
     selected: $.map(scope.selecteds, function (v) {
     return v.id;
     })
     }).replace(/%5B[0-9]%5D/g, '%5B%5D'), function (data) {
     scope.items = data;
     scope.$apply();
     });
     }
     })*/.on('focusout', '#schoolInput',function () {
            $('#schoolsList').hide();
            var scope = APP.RegisterTeacherScope;
            if (!scope.school.id) {
                scope.school.input = '';
                scope.$apply();
            }
        }).on('keyup', '#schoolInput',function () {
            var self = $(this), val = self.val(), old = self.data('value'), scope = APP.RegisterTeacherScope, school = scope.school;
            if (!val) {
                school.id = '';
                school.items = [];
                scope.$apply();
                return;
            }
            if (val != old) {
                school.id = '';
                school.items = [];
                self.data('value', val);
                $.getJSON('/schools', {keyword:val}, function (data) {
                    school.items = data;
                    scope.$apply();
                });
            }
        }).on('click', '.removeSendTo',function () {
            var self = $(this), id = self.attr('data-id'), form = self.closest('form'), input = $('.sendInput', form), scope = APP[form.attr('scope')], selected = [];
            delete scope.ids[id];
            input.data('value', null);
            $.each(scope.selecteds, function (i, v) {
                v.id != id && selected.push(v);
            });
            scope.selecteds = selected;
            scope.$apply();
            return false;
        }).on('click', '.removeAttachment',function () {
            var self = $(this), box = self.closest('.attachments'), index = $('.file', box).index(self.closest('.file')), form = self.closest('form'), scope = APP[form.attr('scope')];
            scope.attachments.splice(index, 1);
            scope.$apply();
            return false;
        })/*.on('click', '.removeTaskAttachment',function () {
            var self = $(this), id = self.attr('data-id'), box = self.closest('.attachments'), index = $('.file', box).index(self.closest('.file')), form = self.closest('form'), scope = APP[box.attr('scope')];
            $.ajax({
                url:'/tasks/' + scope.current + '/attachments/' + id,
                type:'DELETE',
                dataType:'json',
                success:function () {
                    scope.attachments.splice(index, 1);
                    scope.$apply();
                }
            });
            return false;
        })*/.on('focusin', ':text:not(.nofocus),:password,textarea,input[type=number]',function () {
            $(this).addClass('focused');
        }).on('focusout', ':text,:password,textarea,input[type=number]', function () {
            $(this).removeClass('focused');
        })/* .on('click', '.resToolbar', function (e) {
     var self = $(this),
     item = self.closest('.labelsItem,.resItem'),
     isSelected = item.is('.selected'),
     isLabel = item.is('.labelsItem'),
     id = item.attr('data-id'),
     scope = APP.ResourcesScope;
     if (!isSelected) {
     item.addClass('selected');
     !isLabel && scope.selecteds.push(scope.resources.find(function (resource) {
     return id == (resource.id || resource.fileData.id);
     }));
     } else {
     item.removeClass('selected');
     !isLabel && scope.selecteds.remove(function (resource) {
     return id == (resource.id || resource.fileData.id);
     });
     }
     !isLabel && scope.$apply();
     return false;
     })*//*.on('click', '.deleteSelected', function () {
     var scope = APP.ResourcesScope,
     selected = scope.selecteds,
     count = selected.length;
     if (confirm($.LANG(146))) {
     scope.status = 'deleting';
     scope.$apply();
     $.each(selected, function (i, file) {
     $.ajax({
     url: '/resources/' + file.id || file.fileData.id,
     type: 'delete',
     dataType: 'json',
     success: function () {
     count--;
     if (!count) {
     scope.selecteds = [];
     scope.reload();
     scope.status = null;
     scope.$apply();
     }
     }
     });

     });
     }
     })*/.on('click', '.addToAttachments', function () {
            var self = $(this), dialog = self.closest('.dialog'), scope = APP[self.attr('scope')], $scope = APP.CommonScope;
            $.each($scope.picSelecteds, function (i, selected) {
                if (!scope.attachments.find(function (resource) {
                    return selected.id == resource.id;
                })) {
                    scope.attachments.push({
                        id:selected.id,
                        name:selected.name,
                        fileData:selected
                    });
                }
            });
            scope.$apply();
            if (dialog[0]) {
                $('.dialog-close', dialog).click();
            }
            return false;
        })/*.on('click', '.goToLabel', function () {
     var self = $(this),
     scope = APP.ResourcesScope;
     scope.label = {
     id: self.attr('data-id'),
     name: self.text()
     };
     scope.$apply();
     return false;
     })*/.on('click', '.taskInMessage',function () {
            var id = $(this).attr('data-id');
            $.getJSON('/user/tasks/assignment/' + id, function (task) {
                window.location.href = '#/progress/todo?t=' + task.id;
            });
            return false;
        }).on('mouseenter', '.attachment',function () {
            $(this).addClass('attachmentHover');
        }).on('mouseleave', '.attachment', function () {
            $(this).removeClass('attachmentHover');
        })/*.on('click', '.taskButton', function () {
     var self = $(this),
     form = self.closest('form'),
     data = form.serialize(),
     type = self.attr('data-type'),
     draft = type == 'draft',
     action = form.attr('ng-action') + type;
     if (!$.trim($('textarea', form).val())) {
     $.error($.LANG(147));
     return false;
     }
     if (!draft && !confirm($.LANG(148))) {
     return false;
     }
     $.ajax({
     url: action,
     type: 'PUT',
     data: data,
     dataType: 'json',
     success: function () {
     if (draft) {
     $.notify($.LANG(149));
     } else {
     $.notify($.LANG(150));
     APP.TasksScope.reload();
     }
     },
     error: function () {
     $.error((draft ? $.LANG(151) : $.LANG(152)));
     }
     });
     return false;
     })*//*.on('click', '.resourcePreview', function () {
     var self = $(this),
     id = self.attr('data-id'),
     title = $.trim(self.text()) || $.LANG(153);
     APP.Dialog({
     title: title,
     controller: 'ResourceCtrl',
     params: {
     id: id
     },
     url: 'views/resources/show.html'
     });
     return false;
     })*/.on('mouseenter', '.resItem,.labelsItem',function () {
            $(this).addClass('hover');
        }).on('mouseleave', '.resItem,.labelsItem',function () {
            $(this).removeClass('hover');
        }).on('click', '.ResDelete',function (e) {
            e.stopPropagation();
            if (confirm($.LANG(146))) {
                var item = $(this).closest('.resItem'), id = item.attr('data-id'), scope = item.attr('data-scope'), title = item.text();
                $.ajax({
                    url:'/resources/' + id,
                    type:'delete',
                    dataType:'json',
                    success:function () {
                        APP[scope].reload();
                    }
                });
            }
            return false;
        }).on('click', '.LabelEdit',function () {
            var item = $(this).closest('.labelsItem'), id = item.attr('data-id');
            APP.Dialog({
                title:$.LANG(144),
                controller:'LabelCtrl',
                method:'put',
                params:{
                    id:id
                },
                url:'views/labels/edit.html'
            });
            return false;
        }).on('click', '.LabelDelete',function (e) {
            e.stopPropagation();
            if (confirm($.LANG(145))) {
                var item = $(this).closest('.labelsItem'), id = item.attr('data-id'), title = item.text();
                $.ajax({
                    url:'/labels/' + id,
                    type:'delete',
                    dataType:'json',
                    success:function () {
                        APP.LabelsScope.reload();
                    }
                });
            }
            return false;
        }).on('click', '.tabs > ul > li',function () {
            var self = $(this), index = self.index(), tabs = self.closest('.tabs'), panes = $('.tab-pane', tabs);
            if (self.is('.selected'))return;
            self.siblings('.selected').removeClass('selected');
            self.addClass('selected');
            panes.filter('.show').removeClass('show');
            panes.eq(index).addClass('show');
            return false;
        }).on('submit', '#PointForm',function () {
            var self = $(this), action = self.attr('action'), method = self.attr('method'), title = $('[name=title]', self), scope = APP.MapScope, point = scope.cureentPoint, data = {
                geotable:method == 'put' ? {} : {latitude:point.lat, longitude:point.lng}
            };
            data.geotable.title = title.val();
            if (!data.geotable.title) {
                $.error($.LANG(154));
                title.focus();
                return false;
            }
            $.ajax({
                url:action,
                type:method,
                dataType:'json',
                data:data,
                success:function () {
                    scope.InfoWindow.close();
                    scope.getPoints();
                },
                error:$.defaultErrorHandler
            });
            return false;
        }).on('click', '.assignmentType',function (e) {
            e.stopPropagation();
            $('.options', this).show();
            return false;
        }).on('click', '.assignmentType .option',function () {
            var self = $(this), id = self.attr('data-id'), scope = APP.AssignmentsSendToScope;
            scope.assignment.type = scope.types.find(function (type) {
                return type.id == id;
            });
            scope.$apply();
            self.closest('.options').hide();
            return false;
        }).on('click', '.AddGroup',function () {
            APP.Dialog({
                title:$.LANG(79),
                url:'views/groups/new.html'
            });

            return false;
        }).on('click', '.logout',function () {
            $.ajax({
                url:'/users/sign_out',
                type:'delete',
                dataType:'json',
                success:function () {
                    window.location.reload();
                }
            });
        }).on('click', '.filterButton',function () {
            $(this).dropMenu({
                items:[
                    {
                        label:'<i class="iconMark"></i>' + $.LANG(280),
                        methods:{
                            click:function () {
                                var scope = APP.MessageScope;
                                //                                scope.latestParams = {};
                                //                                scope.latestParams['filter[marked]']=true;
                                //                                scope.reload(true,'MyMark');
                                scope.queryByFilter('MyMark');
                            }
                        }
                    },
                    {
                        label:'<i class="icon"></i>' + $.LANG(278),
                        methods:{
                            click:function () {
                                var scope = APP.MessageScope;
                                //                                scope.latestParams = {};
                                //                                scope.latestParams['filter[by_me]']=true;
                                //                                scope.reload(true,'MyPicture');
                                scope.queryByFilter('MyPicture');
                            }
                        }
                    }
                ]
            });
            return false;
        }).on('click', '.languageSelect',function () {
            $(this).dropMenu({
                items:[
                    {
                        label:'简体中文',
                        methods:{
                            click:function () {
                                $.cookie('locale', 'zh-CN', {expires:7, path:'/'});
                                window.location.reload();
                            }
                        }
                    },
                    {
                        label:'English',
                        methods:{
                            click:function () {
                                $.cookie('locale', 'en-US', {expires:7, path:'/'});
                                window.location.reload();
                            }
                        }
                    }
                ]
            });
            return false;
        }).on('click', '.progressButton',function () {
            $(this).dropMenu({
                items:[
                    {
                        label:APP.LANG.progress[0],
                        methods:{
                            click:function () {
                                location.href = '#/progress/published';
                            }
                        }
                    },
                    {
                        label:APP.LANG.progress[1],
                        methods:{
                            click:function () {
                                location.href = '#/progress/todo';
                            }
                        }
                    }
                ]
            });
            return false;
        }).on('click', '.activitiesNav',function () {
            $(this).dropMenu({
                items:[
                    {
                        label:$.LANG(17),
                        methods:{
                            click:function () {
                                window.location.href = '#/discover';
                            }
                        }
                    },
                    {
                        label:$.LANG(269),
                        methods:{
                            click:function () {
                                window.location.href = '#/activities';
                            }
                        }
                    }
                ]
            });
            return false;
        }).click(function () {
            $('.options,.dropMenu').hide();
        });
    setInterval(function () {
        $.each($.scrollBar, function (n, o) {
            o = $(o);
            var _o = o[0];
            if (_o) {
                var w = $('.scroll-wrap', o)[0], s = w.scrollHeight, c = w.clientHeight;
                if (s != o.data('s') || c != o.data('c')) {
                    var bar = $('.scroll-bar', o);
                    if (s > c) {
                        bar.css({
                            height:c * (c / s)
                        }).show();
                        o.data({s:s, c:c});
                    } else {
                        bar.hide();
                    }
                }
            } else {
                delete $.scrollBar[n];
            }
        });
    }, 50);
    $(window).resize(function () {
        $('.leftNav').height(document.body.clientHeight - 234);
    });
});
