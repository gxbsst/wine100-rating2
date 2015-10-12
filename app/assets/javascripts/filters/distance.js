APP.filter('distance', function () {
    return function (distance) {
        if (distance >= 1000) {
            return (Math.round((distance / 1000) * 10) / 10) + $.LANG(307);
        }
        return distance + $.LANG(308);
    };
});