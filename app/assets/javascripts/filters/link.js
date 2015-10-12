APP.filter('link', function () {
    return function (url) {
        if(!/^([\w-]+:\/\/)/i.test(url)){
            url = 'http://' + url;
        }
        return url;
    };
});