APP.directive('ckedit', function (Dialog) {
    var domain = window.location.protocol + '//' + window.location.host;
    CKEDITOR.plugins.add('InsertImage', {
        init:function (editor) {
            editor.addCommand('InsertImage', {
                exec:function (editor) {
                    var dialog = Dialog({
                        title:'插入图片',
                        url:'/views/send/image.html'
                    });
                    dialog.insert = function () {
                        $.each(dialog.picSelecteds, function (i, file) {
                            editor.insertHtml('<img src="' + domain + '{url}" border="0"/>'.replace(/\{(.+?)\}/gi, function () {
                                return file[arguments[1]] || '';
                            }));
                        });
                        dialog.picSelecteds = [];
                        dialog.close();
                    };
                }
            });
            editor.ui.addButton('InsertImage', {
                label:'插入图片',
                icon:this.path + '../../skins/moonocolor/icons.png',
                iconOffset:-936,
                command:'InsertImage'
            });
        }
    });
    return {
        scope:true,
        restrict:'A',
        require:'?ngModel',
        link:function (scope, element, attrs, ngModel) {
            var init = function () {
                var editor = CKEDITOR.replace(element[0], {
                        autoGrow_maxHeight:attrs.maxHeight || 400,
                        autoGrow_minHeight:attrs.minHeight || 80,
                        startupFocus:true,
                        toolbar:attrs.toolbar || 'Basic',
                        height:attrs.height || 80
                    }), update = function () {
                        var data = editor.getData();
                        if (ngModel.$viewValue != data) {
                            !scope.$$phase && scope.$apply(function () {
                                ngModel.$setViewValue(data);
                            });
                            editor.updateElement();
                        }
                    };
                if (!ngModel) return;
                editor.on('pasteState', update);
                editor.on('change', update);
                editor.on('blur', update);
                editor.on('keyup', update);
                scope._model = ngModel;
                scope.$watch('_model.$viewValue', function (value) {
                    if (value != editor.getData()) {
                        editor.setData(value);
                    }
                });
            };
            if (attrs.delay != undefined) {
                element.on('click', init);
            } else {
                init();
            }
        }
    };
});
