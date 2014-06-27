app = angular.module('todo', ['ngResource']);

$(document).on('page:load', function() {
  angular.bootstrap(document.body, ['todo']);
});

app.config([
  '$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
  }
]);

app.factory('Task', function($resource) {
  var task = $resource('/tasks/:id', { id: '@id' }, {
    update: { method: 'PATCH' }
  });
  return task;
});

app.controller('TasksCtrl', function($scope, Task) {
  $scope.tasks = Task.query();
  $scope.task = new Task();

  $scope.addTask = function(task) {
    task.$save(function() {
      $scope.tasks.push(task);
      $scope.task = new Task();
    });
  }
});
