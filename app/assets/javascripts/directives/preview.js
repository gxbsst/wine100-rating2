APP.directive('preview', function ($window, $document, $timeout) {
    return {
        restrict: 'C',
        link: function (scope, element, attrs) {
            scope.$watch('resource', function (resource) {
                if (resource) {
                    var isIE = $.browser.msie,
                        type = resource.name.replace(/.*\.([a-z0-9]+)$/i, '$1').toLowerCase(),
                        image = '<img src="{url}" border="0" />',
                        flash = '<embed src="{url}" width="480" height="400" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode="transparent"></embed>',
                        //media = isIE ? '<embed src="{url}" width="480" height="400" type="application/x-mplayer2" autostart="false" wmode="transparent"></embed>' : '<video src="{url}" width="480" height="400" controls autobuffer></video>',
                        media = '<embed src="{url}" width="480" height="400" type="application/x-mplayer2" autostart="false" wmode="transparent"></embed>',
                        real = '<embed src="{url}" width="480" height="400" type="audio/x-pn-realaudio-plugin" controls="ImageWindow" autostart="false" wmode="transparent"></embed>',
                        //audio = isIE ? '<embed src="{url}" width="200" height="45" type="application/x-mplayer2" controls="ImageWindow" autostart="false" wmode="transparent"></embed>' : '<video src="{url}" width="480" height="400" controls autobuffer></video>',
                        audio = '<embed src="{url}" width="200" height="45" type="application/x-mplayer2" controls="ImageWindow" autostart="false" wmode="transparent"></embed>',
                        link = '<div class="download"><div>{name}</div><a href="{url}&attchment={name}" class="button" target="_blank">' + $.LANG(261) + '</a></div>';
                    if(!swfobject.ua.pv[0]){
                        flash = '<object width="480" height="400" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><param value="/expressInstall.swf" name="movie"><param value="transparent" name="wmode"><param value="high" name="quality"><param value="always" name="allowScriptAccess"><embed width="480" height="400" allowscriptaccess="always" type="application/x-shockwave-flash" src="/expressInstall.swf"></object>';
                    }
                    var template = {
                            jpg: image,
                            jpeg: image,
                            gif: image,
                            png: image,
                            bmp: image,
                            swf: flash,
                            flv: flash,
                            mov: media,
                            avi: media,
                            wmv: media,
                            mp4: media,
                            mp3: audio,
                            mid: audio,
                            rm: real,
                            rmvb: real,
                            unknown: link
                        },
                        html;
                    if(resource.flash){
                        html = '<embed src="{flash}" width="100%" height="100%" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>';
                        if(!swfobject.ua.pv[0]){
                            html = '<object width="100%" height="100%" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><param value="/expressInstall.swf" name="movie"><param value="transparent" name="wmode"><param value="high" name="quality"><param value="always" name="allowScriptAccess"><embed width="100%" height="100%" allowscriptaccess="always" type="application/x-shockwave-flash" src="/expressInstall.swf"></object>';
                        }
                        if(resource.downloadable){
                            html += '<a href="{url}" target="_blank"><i class="icon25 iconDownload"></i>' + $.LANG(261) + '</a>';
                        }
                        html = '<div class="flashPaper" style="width:800px;height:'+($document[0].body.clientHeight *.85)+'px;">'+html+'</div>';
                    }else{
                        if(/\.(doc|docx|ppt|pptx|xls|xlsx|pdf|txt)$/i.test(resource.name)){
                            html = '<div class="flashPaper">' + $.LANG(298) + '</div>';
                        }else{
                            html = template[type];
                            if (!html) {
                                html = template.unknown;
                                element.css({width: 350, height: 180});
                            }
                        }
                    }
                    html = angular.element(html.replace(/\{(.+?)\}/gi, function () {
                        return resource[arguments[1]] || '';
                    }));
                    if (resource.flash){
                        element.replaceWith(html);
                    }else if(/jpg|jpeg|gif|png|bmp/.test(type)) {
                        var width = parseInt((attrs.dataWidth || attrs.width || 480), 10),
                            height = parseInt((attrs.dataHeight || attrs.height || 400), 10),
                            img = new Image();
                        img.onerror = function () {
                            html.attr('src', '/images/error.png');
                        };
                        img.onload = function () {
                            if (this.width > width || this.height > width) {
                                if (this.width > this.height) {
                                    html.attr('width', width).css({marginTop: -((width / this.width) * this.height / 2), marginLeft: -(width / 2)});
                                } else {
                                    html.attr('height', height).css({marginLeft: -((height / this.height) * this.width / 2), marginTop: -(height / 2)});
                                }
                            } else {
                                html.css({marginLeft: -(this.width / 2), marginTop: -(this.height / 2)})
                            }
                            element.html(html.attr('src', resource.url));
                        };
                        img.src = resource.url;
                    } else {
                        element.html(html);
                    }
                }
            });
        }
    }
});
