APP.filter('html', function($sce){
    return function(html){
        return $sce.trustAsHtml(html);
    }
});