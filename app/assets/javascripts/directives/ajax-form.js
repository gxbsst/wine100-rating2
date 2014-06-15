APP.directive('ajax', function () {
    return {
        link: function (scope, element, attrs) {
            attrs.focused != 'false' && $(':input:first', element).focus();
            var callback = scope[attrs.callback] || scope.callback || function () {
            };
            element.on('submit', function () {
                if (element.is('.disabled') || scope._FormStatus == 'submitting' || element.data('ajaxValid')) {
                    return false;
                }
                var _this = this,
                    self = scope[attrs.name],
                    action = attrs.action || attrs.ngAction,
                    method = attrs.method || 'post',
                    reload = attrs.reload,
                    el = $(element),
                    data = el.serialize(),
                    success = function (data) {
                        scope._FormStatus = 'submitted';
                        $('button[type="submit"],.button[type="submit"]', element).removeClass('disabled').removeAttr('disabled', true);
                        attrs.notify != 'false' && $.notify($.LANG(202));
                        reload && $.each(reload.split(','), function (i, name) {
                            name = $.trim(name || '');
                            var scope = APP[name],
                                params = [];
                            if (attrs.params) {
                                try {
                                    params = eval('([' + attrs.params + '])');
                                } catch (e) {
                                }
                            }
                            scope && scope.reload && scope.reload.apply(this, params);
                        });
                        callback.call(_this, data);
                        $('input,textarea', _this).each(function () {
                            $(this).blur();
                        });
                        var dialog = el.closest('.dialog');
                        if (dialog[0]) {
                            $('.dialog-close', dialog).click();
                        }
                    };
                if (self.$valid) {
                    var validation = scope[attrs.validation] || scope['validation'];
                    if (validation && !validation.call(scope, self)) {
                        return false;
                    }
                    scope._FormStatus = 'submitting';
                    $('button[type="submit"],.button[type="submit"]', element).addClass('disabled').attr('disabled', true);
                    $.ajax({
                        url: action,
                        type: method,
                        data: data,
                        dataType: 'json',
                        success: success,
                        error: function (res) {
                            scope._FormStatus = 'submitted';
                            $('button[type="submit"],.button[type="submit"]', element).removeClass('disabled').removeAttr('disabled', true);
                            var status = res.status;
                            if (status < 400) {
                                success();
                            } else if (status >= 400 && status < 500) {
                                $.error(res.responseJSON);
                            } else if (status >= 200 && status < 300) {
                                $.notify($.LANG(202));
                            } else {
                                $.error($.LANG(173));
                            }
                        }
                    });
                } else {
                    $.each(self.$error, function (type, error) {
                        $.each(error, function (i, v) {
                            var el = $('[name="' + v.$name + '"]', el),
                                name = el.attr('errorText') || el.attr('placeholder') || el.attr('placehold') || v.$name,
                                message = {
                                    required: $.LANG(204),
                                    email: $.LANG(205),
                                    number: $.LANG(206),
                                    min: $.LANG(207, {min: el.attr('min')})
                                }[type] || $.LANG(203);
                            $.error(v.$errorText || ('【' + name + '】' + message));
                        });
                    });
                }
                return false;
            });
        }
    }
});
