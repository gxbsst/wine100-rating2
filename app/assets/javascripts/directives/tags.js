APP.directive('ngTags', function () {
    return {
        restrict: 'A',
        //scope: true,
        replace: true,
        template: '<div class="ng-tags"><input type="hidden" name="{{ fieldName }}" ng-model="tags" ng-value="tags|string"/><span class="ng-tag" ng-repeat="tag in tags">{{ tag }}<i class="icon iconCloseWhite" ng-click="removeTag(tag)"></i></span><input type="text" class="input" ng-blur="blur()" ng-keypress="keypress($event)" ng-model="_tag" placeholder="{{ LANG.322|lang }}"/><div class="clear"></div></div>',
        link: function (scope, element, attrs) {
            scope._tag = '';
            scope._tags = {};
            scope.tags = [];
            scope.fieldName = attrs.ngTags || 'tags';
            scope.addTag = function () {
                if (scope._tag && !scope._tags[scope._tag]) {
                    scope.tags.push(scope._tag);
                    scope._tags[scope._tag] = 1;
                    scope._tag = '';
                }
            };
            scope.keypress = function ($event) {
                if ($event.which == 13) {
                    scope.addTag();
                    $event.stopPropagation();
                    $event.preventDefault();
                    return false;
                }
            };
            scope.blur = function () {
                scope.addTag();
            };
            scope.removeTag = function (tag) {
                delete scope._tags[tag];
                scope.tags.remove(tag);
            };
        }
    };
});
