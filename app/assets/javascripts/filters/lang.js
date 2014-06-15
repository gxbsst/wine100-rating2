APP.filter('lang', function () {
    return function (lang, data) {
        return (lang || '').replace(/\{(.+?)\}/gi, function () {
            return (data && data[arguments[1]]) || '';
        }) || '...';
    };
});