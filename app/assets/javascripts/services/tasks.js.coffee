APP.service('Tasks', ($resource) ->
   $resource '/projects/:project_id/tasks/:id', {project_id: "@project_id", id: "@id"}
)