APP.filter('string', function () {
    return function (object) {
        if(!object){
            return '';
        }
        return object.join(',');
    };
});