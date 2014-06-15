APP.filter('gender', function () {
    return function (gender) {
        return {
            unknow: $.LANG(26),
            male: $.LANG(85),
            female: $.LANG(86)
        }[gender || 'unknow'];
    };
});