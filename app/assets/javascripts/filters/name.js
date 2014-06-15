APP.filter('name', function () {
    return function (user) {
        if(user){
            return user.name || '...';
            //return /^zh/.test(APP.locale) ? user.last_name + user.first_name : user.first_name + ' ' + user.last_name;
        }
        return '...';
    };
});