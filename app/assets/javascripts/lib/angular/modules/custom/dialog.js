angular.module('DialogService', []).factory('Dialog', function ($document, $compile, $timeout) {
    var body = $document.find('body')/*,
     DIALOG = $rootScope.$new(),
     container = angular.element('<div class="dialogs">' +
     '<div ng-repeat="item in items">' +
     '   <div class="backdrop" ng-if="item.backdrop"></div>' +
     '   <div class="dialog" ng-if="!item.backdrop">' +
     '       <div class="dialog-title" ng-bind-html="item.title"></div>' +
     '       <div class="dialog-content" ng-if="item.html" ng-bind-html="item.html"></div>' +
     '       <div class="dialog-content" ng-if="item.url" ng-include="\'item.url\'"><div class="loading"></div></div>' +
     '   </div>' +
     '</div>' +
     '</div>');
     DIALOG.items = [];
     $compile(container)(DIALOG);
     body.append(container)*/;
    return function (opts) {
        /*var def = {
         title: null,
         width: null,
         height: null,
         html: null,
         url: null,
         css: {},
         controller: null,
         backdrop: true
         };
         opts = opts || {};
         opts = angular.extend(def, opts);
         var scope = APP[opts.scope] || DIALOG.$new();
         //DIALOG.push();
         !DIALOG.$$phase && DIALOG.$apply();*/
        var def = {
            id: null,
            title: null,
            width: null,
            height: null,
            html: null,
            url: null,
            css: {},
            controller: null,
            backdrop: true,
            autoClose: null
        };
        opts = opts || {};
        opts = angular.extend(def, opts);
        $('.backdrop').hide();
        var scope = (APP[opts.scope] || APP.Root).$new(),
            modalEl = angular.element('<div class="dialog" ' + (opts.controller ? 'ng-controller="' + opts.controller + '"' : '') + '>' +
                '<div class="dialog-title">' + opts.title + '<a href="javascript:void(0);" class="dialog-close" ng-click="close()">X</a></div>' +
                (opts.html ? '<div class="dialog-content">' + opts.html + '</div>' : '<div class="dialog-content" ng-include="\'' + opts.url + '\'"><div class="loading"></div></div>') +
                '</div>'),
            contentEl = modalEl.find('.dialog-content'),
            backdropEl = angular.element('<div class="backdrop"></div>');
        scope.close = function () {
            modalEl.remove();
            if (opts.backdrop) {
                backdropEl.remove();
            }
            $('.backdrop').last().show();
        };
        scope.$watch(function () {
            modalEl.css({marginLeft: -(modalEl.width() / 2), marginTop: -(modalEl.height() / 2)});
        });
        if (opts.width) {
            opts.css.width = opts.width;
        }
        if (opts.height) {
            opts.css.height = opts.height;
        }
        if (opts.params) {
            scope.params = opts.params;
        }
        contentEl.css(opts.css);
        if (opts.callback) {
            scope.callback = opts.callback;
        }
        if (opts.data) {
            $.each(opts.data, function (n, v) {
                scope[n] = v;
            });
        }
        if (typeof opts.autoClose == 'number') {
            $timeout(function () {
                scope.close();
            }, opts.autoClose * 1000);
        }
        $compile(backdropEl)(scope);
        $compile(modalEl)(scope);
        if (opts.backdrop) body.append(backdropEl);
        body.append(modalEl);
        !scope.$$phase && scope.$apply();
        return scope;
    };
});