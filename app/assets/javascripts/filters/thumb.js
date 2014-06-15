APP.filter('thumb', function () {
    return function (resource) {
        var name = resource.name || '.unknow',
            type = name.replace(/.*\.([a-z0-9]+)$/i, '$1');
        if(/^(jpg|jpeg|gif|bmp|png|ico|cur)$/ig.test(type)){
            return resource.url;
        }else{
            return 'ico/' + type + '.png';
        }
    };
});