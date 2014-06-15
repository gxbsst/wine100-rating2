APP.service 'UserProjects', ($resource, Actions) ->
  $resource 'users/:user_id/projects', {user_id: '@user_id'}, Actions