(function ($) {
    var types = ['DOMMouseScroll', 'mousewheel'];
    if ($.event.fixHooks) {
        for (var i = types.length; i;) {
            $.event.fixHooks[ types[--i] ] = $.event.mouseHooks;
        }
    }
    $.event.special.mousewheel = {
        setup:function () {
            if (this.addEventListener) {
                for (var i = types.length; i;) {
                    this.addEventListener(types[--i], handler, false);
                }
            } else {
                this.onmousewheel = handler;
            }
        },
        teardown:function () {
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
        mousewheel:function (fn) {
            return fn ? this.bind("mousewheel", fn) : this.trigger("mousewheel");
        },
        unmousewheel:function (fn) {
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

        // Add event and delta to the front of the arguments
        args.unshift(event, delta, deltaX, deltaY);

        return ($.event.dispatch || $.event.handle).apply(this, args);
    }

})(jQuery);
$.extend({
    scrollBar:{},
    LANG:function (code, data) {
        return (APP.LANG && APP.LANG[code + ''] || '').replace(/\{(.+?)\}/gi, function () {
            return data[arguments[1]] || '';
        }) || '...';
    },
    username:function (first, last) {
        return /^zh/.test(APP.locale) ? last + first : first + ' ' + last;
    },
    query:function (name, query) {
        query = query || window.location.search.substr(1);
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = query.match(reg);
        if (r != null) {
            return decodeURIComponent(r[2]);
        }
        return null;
    },
    wait:function (fn, callback) {
        if (fn.call(null)) {
            callback.apply();
        } else {
            setTimeout(function () {
                $.wait(fn, callback);
            }, 20);
        }
    },
    typeOf:function (o) {
        if (o instanceof jQuery) {
            return 'jquery';
        }
        if (o instanceof Object && Object.prototype.toString.call(o) == '[object Object]' && !o.length) {
            return 'json';
        }
        return Object.prototype.toString.call(o).match(/\[object\s(.+)\]/)[1].toLowerCase();
    },
    message:function (text, type, delay) {
        if (typeof type == 'number') {
            delay = type;
            type = 'notify';
        }
        delay = delay || 6000;
        var box = $('.messageContainer');
        if (!box[0]) {
            box = $('<div class="messageContainer"></div>').appendTo('body');
        }
        var message = $('<div class="message message-' + type + '" style="top:' + top + 'px"><div class="messageText">' + text + '</div></div>').appendTo(box);
        message.on('click', function () {
                message.animate({
                    marginTop:-50,
                    opacity:0
                }, 200, function () {
                    message.remove();
                });
            }).css({
                marginTop:-50,
                opacity:0
            }).show().animate({
                marginTop:5,
                opacity:1
            }, 200);
        delay && setTimeout(function () {
            if (message[0]) {
                message.animate({
                    marginTop:-50,
                    opacity:0
                }, 200, function () {
                    message.remove();
                });
            }
        }, delay);
    },
    notify:function (notify) {
        if (!notify)return;
        if (typeof notify == 'string') {
            try {
                notify = $.parseJSON(notify);
            } catch (e) {
            }
        }
        var handle = function (value) {
            if (typeof value == 'string') {
                $.message(value, 'notify');
            } else {
                $.each(value, function (n, v) {
                    handle(v);
                });
            }
        };
        handle(notify);
    },
    error:function (error) {
        if (!error)return;
        if (typeof error == 'string') {
            try {
                error = $.parseJSON(error);
            } catch (e) {
            }
        }
        var handle = function (value) {
            if (typeof value == 'string') {
                $.message(value, 'error');
            } else {
                $.each(value, function (n, v) {
                    handle(v);
                });
            }
        };
        handle(error);
    },
    defaultErrorHandler:function (res) {
        var status = res.status;
        if (status >= 400 && status < 500) {
            $.error(res.responseJSON);
        } else if (status >= 200 && status < 300) {
            $.notify($.LANG(202));
        } else {
            $.error($.LANG(173));
        }
    }
});

$.fn.extend({
    scrollBar:function (opts) {
        opts = opts || {};
        var self = $(this), css = {
                position:'relative',
                overflow:'hidden'
            }, bar = $('<div class="scroll-bar"></div>');
        self.wrapInner('<div class="scroll-wrap"></div>');
        bar.appendTo(self);
        var wrap = $('.scroll-wrap', self), s = wrap[0].scrollHeight, c = wrap[0].clientHeight;
        if (opts.autoHeight) {
            var offset = opts.offset || self.offset();
            css.height = $(document).height() - offset.top;
        }
        bar.css({
            height:c * (c / s)
        });
        self.bind('mouseenter',function () {
            bar.addClass('hover');
        }).bind('mouseleave',function () {
                bar.removeClass('hover');
            }).bind('mousewheel',function (event, delta) {
                event = event || window.event;
                event.stopPropagation();
                s = wrap[0].scrollHeight;
                c = wrap[0].clientHeight;
                wrap[0].scrollTop += (delta > 0 ? -50 : 50);
                bar.css({
                    top:wrap[0].scrollTop * (c / s)
                });
                return false;
            }).css(css);
        bar.bind('mousedown', function (event) {
            event = event || window.event;
            var pos = bar.position(), sc = self[0].scrollHeight / self.height(), y = event.pageY;
            $.POS = {y:y, top:pos.top};
            $(document).bind('mousemove', function (event) {
                event = event || window.event;
                var y = event.pageY, top = $.POS.top - ($.POS.y - y);
                if (top < 0) {
                    top = 0;
                }
                if (top >= self.height() - bar.height()) {
                    top = self.height() - bar.height();
                }
                bar.css({top:top});
                wrap[0].scrollTop = top * sc;
                return false;
            });
            return false;
        });
        $(document).bind('mouseup', function () {
            $(document).unbind('mousemove');
        });
        return self;
    },
    uiTips:function () {
        var tip = $('.tips'), content = $('.tips-content', tip);
        if (!tip[0]) {
            tip = $('<div class="tips"><div class="tips-arrow"></div><div class="tips-content"></div></div>').appendTo('body');
            content = $('.tips-content', tip);
        }
        $(this).each(function () {
            var self = $(this), offset = self.offset(), width = self.outerWidth(), height = self.outerHeight();

        });
        return this;
    },
    uiSelect:function (width) {
        width = width || 220;
        this.wrap('<span class="select-wrap"></span>');
        return this;
    },
    /*uiSelect: function (width, defaultText) {
     if (typeof width == 'string') {
     defaultText = width;
     width = 220;
     }
     width = width || 220;
     defaultText = defaultText || '请选择';
     var self = $(this),
     name = self.attr('name'),
     opts = $('option', self),
     selected = '',
     html = [];
     self.hide();
     opts.each(function (i) {
     var opt = $(this),
     text = opt.text(),
     isSelected = opt.is(':selected');
     if (!i || isSelected) {
     selected = text;
     }
     html.push('<div class="option' + (isSelected ? ' option-selected' : '') + '">' + text + '</div>');
     });
     var select = $('<div class="select"><div class="select-text">' + (selected || defaultText) + '</div><div class="select-arrow"><i class="icon iconSelectArrow"></i></div><div class="options">' + html.join('') + '</div></div>').insertAfter(self),
     $text = $('.select-text', select),
     options = $('.options', select);
     if (width) {
     $text.css({width: width - 30});
     }
     select.click(function (event) {
     event = event || window.event;
     event.stopPropagation();
     options.show();
     });
     $('.option', select).hover(function () {
     $(this).addClass('option-hover');
     },function () {
     $(this).removeClass('option-hover');
     }).click(function () {
     var option = $(this).addClass('option-selected'),
     index = option.index(),
     selected = $('option', self).eq(index),
     val = selected.val(),
     text = selected.text();
     option.siblings('.option-selected').removeClass('option-selected');
     options.hide();
     $text.text(text);
     $(':selected', self).attr('selected', false);
     selected.attr('selected', true);
     self.trigger('change', [val, text]);
     return false;
     });
     return this;
     },*/
    placeHolder:function () {
        var input = $(this), auto = input.is('[auto-css]'), text = input.attr('placeholder'), wrap = input.wrap('<span class="placeholder"></span>'), placeholder = $('<span class="placeholder-text">' + text + '</span>').insertAfter(input), change = function () {
                if (input.val() != '') {
                    placeholder.hide();
                } else {
                    placeholder.show();
                }
            };
        if (auto) {
            placeholder.css({
                paddingLeft:input.css('paddingLeft') + input.css('borderLeftWidth'),
                paddingTop:input.css('paddingTop') + input.css('borderTopWidth'),
                lineHeight:input.css('lineHeight')
            });
        }
        placeholder.click(function () {
            input.focus();
        });
        input.on('focusin',function () {
            input.selectRange(0, 0);
        }).on('keyup', change).on('input', change).on('change', change).on('focusout', change).on('propertychange', change);
        return this;
    },
    selectRange:function (start, end) {
        return this.each(function () {
            if (this.setSelectionRange) {
                this.setSelectionRange(start, end);
            } else if (this.createTextRange) {
                var range = this.createTextRange();
                range.collapse(true);
                range.moveEnd('character', end);
                range.moveStart('character', start);
                range.select();
            }
        });
    },
    dropMenu:function (opts) {
        opts = opts || {};
        var self = $(this), id = self.attr('id'), menu = self.data('dropMenu'), offset = self.offset(), width = self.outerWidth(), height = self.outerHeight(), left = offset.left + (width / 2), top = offset.top + height + 8, def = {
                id:'dropMenu-' + (id || +new Date()),
                html:null,
                width:100
            };
        opts = $.extend(def, opts);
        $('.dropMenu').hide();
        if (!menu) {
            menu = $('#dropMenu-' + id);
        }
        if (!menu[0]) {
            menu = $('<div class="dropMenu" id="' + opts.id + '"><span class="arrow"></span><div class="content"></div></div>').appendTo('body');
            var content = $('.content', menu);
            if (opts.html) {
                content.html(opts.html);
            }
            $.each(opts.items, function (i, item) {
                var _item = $('<a href="' + (item.href || 'javascript:void(0);') + '" class="item">' + item.label + '</a>');
                if (item.target) {
                    _item.attr('target', item.target);
                }
                $.each(item.methods || {}, function (name, fn) {
                    _item.on(name, fn);
                });
                _item.appendTo(content);
            });
        }
        menu.css({width:opts.width, left:left, top:top, marginLeft:-(opts.width / 2)}).show();
        self.data('dropMenu', menu);
        return this;
    }
});