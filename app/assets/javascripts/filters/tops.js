APP.filter('tops', function () {
    return function (i) {
        i++;
        if (i < 10) {
            i = '0' + i;
        }
        return i;
    };
});