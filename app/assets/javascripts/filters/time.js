APP.filter('time', function () {
    return function (time, unix) {
        unix = unix == false ? unix : true;
        if(!time){
            return '--';
        }
        if(typeof time == 'string'){
            time = new Date(Date.parse(time.replace(/-/g,'/').replace('T',' ').replace(/\+.*$/,'')));
        }
        if(typeof time == 'number'){
            time = time.toDate(unix);
        }
        if(!angular.isDate(time)){
            time = new Date();
        }
        return time.format();
    };
});