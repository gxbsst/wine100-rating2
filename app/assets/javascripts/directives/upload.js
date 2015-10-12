APP.directive('uploadConfig', function ($timeout) {
    return {
        link: function (scope, element, attrs) {
            $timeout(function () {
                var defaults = {
                        action: '/upload',
                        method: 'POST',
                        name: 'file',
                        image: 'swfupload/button.png',
                        width: 115,
                        height: 32,
                        multiple: true,
                        limit: 104857600,
                        params: {},
                        callback: function () {
                        }
                    },
                    button = element.find('span'),
                    config = scope.config = scope.$eval('{' + (attrs.uploadConfig || '') + '}'),
                    parent = (config.scope && APP[config.scope]) || scope.$parent,
                    upload = parent.upload = {
                        status: 'wait',
                        files: [],
                        fileKeys: {}
                    },
                    queue = upload.files,
                    keys = upload.fileKeys;
                if (!button[0]) {
                    button = element;
                }
                config = angular.extend(defaults, config);
                if ($.browser.msie) {
                    new SWFUpload({
                        upload_url: config.action,
                        flash_url: 'swfupload/swfupload.swf',
                        file_size_limit: '100 MB',
                        file_upload_limit: config.multiple ? 0 : 1,
                        file_types: config.types ? config.types.replace(/[a-zA-Z0-9]+\/([a-zA-Z0-9]+)/gi, '*.$1').replace(/,/g, ';') : '*.*',
                        file_types_description: $.LANG(201),
                        file_post_name: config.name,
                        button_image_url: config.image,
                        button_placeholder: button[0],
                        button_width: config.width,
                        button_height: config.height,
                        button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
                        button_cursor: SWFUpload.CURSOR.HAND,
                        post_params: $.extend({
                            _method: config.method,
                            'authenticity_token': $.ajaxSettings.headers['X-CSRF-Token']
                        }, config.params),
                        headers: {
                            'X-CSRF-Token': $.ajaxSettings.headers['X-CSRF-Token'],
                            'X-LANGUAGE-LOCALE': $.ajaxSettings.headers['X-LANGUAGE-LOCALE']
                        },
                        file_queued_handler: function (file) {
                            var key = $.getFileKey(file);
                            if (keys[key]) {
                                this.cancelUpload(file.id, false);
                            } else {
                                keys[key] = true;
                                file.progress = 0;
                                file.statusText = '<font color="gray">'+ $.LANG(197) +'</font>';
                                upload.queued = file;
                                queue.push(file);
                                parent.$apply();
                            }
                        },
                        file_queue_error_handler: function (file, errorCode, message) {
                            $.error({
                                '-110': $.LANG(194, {name: file.name, limit: this.settings.file_size_limit}),
                                '-120': $.LANG(195, {name: file.name}),
                                '-130': $.LANG(196, {name: file.name})
                            }[errorCode + '']);
                        },
                        file_dialog_complete_handler: function () {
                            if (this.getStats().files_queued > 0) {
                                upload.status = 'uploading';
                                parent.$apply();
                                this.startUpload();
                            }
                        },
                        upload_start_handler: function (file) {
                            this.setButtonDisabled(true);
                            this.setButtonCursor(SWFUpload.CURSOR.ARROW);
                            var item = queue.get(function (i) {
                                return i.id === file.id;
                            });
                            if (item) {
                                item.statusText = '<font color="#ff6600"><i>'+ $.LANG(198) +'</i></font>';
                                parent.$apply();
                            }
                        },
                        upload_progress_handler: function (file, uploaded, total) {
                            var item = queue.get(function (i) {
                                return i.id === file.id;
                            });
                            if (item) {
                                item.progress = uploaded / total;
                                parent.$apply();
                            }
                        },
                        upload_success_handler: function (file) {
                            var item = queue.get(function (i) {
                                return i.id === file.id;
                            });
                            if (item) {
                                item.progress = 1;
                                item.statusText = '<font color="green">'+ $.LANG(199) +'</font>';
                                item.fileData = file;
                                parent.$apply();
                            }
                        },
                        upload_error_handler: function (file) {
                            var item = queue.get(function (i) {
                                return i.id === file.id;
                            });
                            if (item) {
                                item.statusText = '<font color="red">'+ $.LANG(200) +'</font>';
                                parent.$apply();
                            }
                        },
                        upload_complete_handler: function () {
                            if (this.getStats().files_queued > 0) {
                                this.startUpload();
                            } else {
                                this.setButtonDisabled(false);
                                this.setButtonCursor(SWFUpload.CURSOR.HAND);
                                upload.status = 'completed';
                                config.callback.call(null, upload);
                                parent.$apply();
                            }
                        }
                    });
                } else {
                    var index = 0,
                        input = {
                            type: 'file',
                            name: config.name,
                            id: config.name
                        },
                        start = function () {
                            var file = queue[index],
                                xhr = new XMLHttpRequest(),
                                fd = new FormData();
                            file.status = 'uploading';
                            file.statusText = '<font color="green">'+ $.LANG(198) +'</font>';
                            xhr.upload.addEventListener('progress', function (evt) {
                                if (evt.lengthComputable) {
                                    file.progress = evt.loaded / evt.total;
                                    parent.$apply();
                                }
                            }, false);
                            xhr.addEventListener('load', function (data) {
                                try{
                                    data = $.parseJSON(xhr.responseText);
                                }catch(e){}
                                file.status = 'completed';
                                file.progress = 1;
                                file.statusText = '<font color="green">'+ $.LANG(199) +'</font>';
                                file.fileData = data;
                                if (index === queue.length - 1) {
                                    upload.status = 'completed';

                                    config.callback.call(null, upload);
                                } else {
                                    index++;
                                    start();
                                }
                                parent.$apply();
                            }, false);
                            xhr.addEventListener('error', function () {
                                file.status = 'failed';
                                file.statusText = '<font color="red">'+ $.LANG(200) +'</font>';
                                parent.$apply();
                            }, false);
                            xhr.open(config.method, config.action, true);
                            xhr.setRequestHeader('X-CSRF-Token', $.ajaxSettings.headers['X-CSRF-Token']);
                            xhr.setRequestHeader('X-LANGUAGE-LOCALE', $.ajaxSettings.headers['X-LANGUAGE-LOCALE']);
                            xhr.setRequestHeader('Accept', 'application/json; charset=utf-8');
                            fd.append(config.name, queue[index].file);
                            $.each(config.params, function (n, v) {
                                fd.append(n, v);
                            });
                            xhr.send(fd);
                        };
                    if (config.multiple) {
                        input.multiple = 'multiple';
                    }
                    if (config.types) {
                        input.accept = config.types;
                    }
                    var inputAttrs = [];
                    $.each(input, function (n, v) {
                        inputAttrs.push(n + '=' + v);
                    });
                    input = $('<input ' + inputAttrs.join(' ') + ' />').hide().insertBefore(button);
                    if (config.replace) {
                        button.replaceWith('<a href="javascript:void(0);" ng-disabled="upload.status==\'uploading\'" ng-class="{disabled:upload.status==\'uploading\'}" class="button" type="file">' + $.LANG(158) + '</a>');
                    } else {
                        button.attr({
                            type: 'file'
                        });
                    }
                    input.on('change', function () {
                        index = 0;
                        queue = upload.files = [];
                        $.each(this.files, function (i, file) {
                            if (config.limit > 0 && file.size < config.limit) {
                                upload.queued = {
                                    name: file.name,
                                    file: file,
                                    progress: 0,
                                    status:'waiting',
                                    statusText: '<font color="gray">' + $.LANG(157) + '</font>'
                                };
                                queue.push(upload.queued);
                            } else {
                                $.error($.LANG(194, {limit: config.limit.toByte()}));
                            }
                            parent.$apply();
                        });
                        if (queue.length) {
                            upload.status = 'uploading';
                            parent.$apply();
                            start();
                        }
                    });
                }
            }, 0);
        }
    };
});