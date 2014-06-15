APP.filter('each', function () {
    return function (number) {
        var array = [];
        for (var i = 0; i < number; i++) {
            array.push(i+1);
        }
        return array;
    };
});