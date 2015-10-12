APP.directive('ngMenu', function (){
    return function (scope, element, attrs){
        scope.$watch('LANG', function (LANG){
            if (LANG) {
                var config = scope.$eval(attrs.ngMenu);
                var items = [];
                $.each(config, function (name, action){
                    var opts = {
                        label:name
                    };
                    switch (typeof action) {
                        case 'string':
                            opts.href = action;
                            if (/^http:\/\//.test(action)) {
                                opts.target = '_blank';
                            }
                            break;
                        case 'function':
                            opts.methods = {
                                click:action
                            };
                            break;
                    }
                    items.push(opts);
                });
                element.on('click', function (){
                    element.dropMenu({
                        items:items
                    });
                    return false;
                });
            }
        });
    };
});
