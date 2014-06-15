APP.filter('userType', function () {
    return function (user) {
        if(user.profile && user.profile.additional_info){
            return user.profile.additional_info;
        }
        return APP.LANG.roles[user.title] || APP.LANG.roles[user.type] || APP.LANG.roles['unknow'];
    };
});