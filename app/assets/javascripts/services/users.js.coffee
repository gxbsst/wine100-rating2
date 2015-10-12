APP.service 'Users', ($resource, Actions) ->
  $resource('/users/:id', {id: '@id'}, Actions)