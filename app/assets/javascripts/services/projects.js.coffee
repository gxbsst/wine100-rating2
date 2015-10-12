APP.service 'ProjectsActions', ($resource, Actions) ->
  $resource '/projects/:id', {id: '@id'}, Actions

