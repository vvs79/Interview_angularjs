app = angular.module("Interview", ["ngResource"])

app.factory "Interview", ["$resource", ($resource) ->
  $resource("/interviews/:id.json", {id: "@id"})
]

app.controller 'InterviewCtrl', ['$scope', 'Interview', ($scope, Interview) ->
  $scope.interviews = Interview.query()

  $scope.addInterview = ->
    interview = Interview.save($scope.newInterview)
    $scope.interviews.push(interview)
    $scope.newInterview = {}

  $scope.removeInterview = (int) ->
    int.$remove()
    $scope.interviews.splice($scope.interviews.indexOf(int), 1)
]
