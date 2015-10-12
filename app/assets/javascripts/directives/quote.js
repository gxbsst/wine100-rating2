APP.directive('quote', function (Post) {
    return {
        restrict:'E',
        replace:true,
        template:'<div class="quote" ng-style="{fontStyle:expandQuote?\'italic\':\'normal\',maxHeight:expandQuote?\'100px\':(maxHeight||\'inherit\')}">' +
            '<div ng-if="originalLoaded" ng-include="\'views/posts/quote/original.html\'"></div>' +
            '<div ng-if="!originalLoaded" ng-include="\'views/posts/quote/summary.html\'"></div>' +
            '</div>',
        link:function (scope, element, attrs) {
            var message = scope.message,
                post = message.post.quote || message.post,
                quote = (post.content || post.description).replace(/<[^>].*?>/g, '');
            if (quote.length > 150) {
                quote = quote.substr(0, 150) + '...';
            }
            scope.expand = function(){
                var post = message.post.quote || message.post;
                Post.get({id:post.id}, function(post){
                    scope.post = post;
                    scope.originalLoaded = true;
                });
            };
            scope.quote = quote;
        }
    };
});