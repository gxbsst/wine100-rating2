APP.service 'JoinRequests', ($resource, Actions) ->
  $resource '/join_requests/:id', {id: "@id"}, Actions