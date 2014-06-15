APP.filter('toArray', function () {
    return function (string) {
        return (string || '').split(',');
    };
});