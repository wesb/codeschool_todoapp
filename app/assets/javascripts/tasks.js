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

app.factory('Task', ['$resource', function($resource) {
  var task = $resource('/tasks/:id', { id: '@id' }, {
    update: { method: 'PATCH' }
  });
  return task;
}]);

app.controller('TasksCtrl', ['$scope', 'Task', function($scope, Task) {
  $scope.tasks = Task.query();
  $scope.task = new Task();

  $scope.addTask = function(task) {
    if (task.title && task.title.length > 0) {
      task.$save(function(r) {
        $scope.tasks.push(task);
        $scope.task = new Task();
      });
    }
  }

  $scope.updateTask = function(task) {
    task.$update();
  }

  $scope.deleteTask = function(task, index) {
    task.$delete(function() {
      $scope.tasks.splice(index, 1);
    });
  }
}]);

app.directive('taskProgress', function() {
  return {
    templateUrl: 'task-progress.html',
    link: function($scope) {
      $scope.$watch('tasks', function(newValue, oldValue) {
        updateProgress();
      }, true);
      function updateProgress() {
        var completed = 0;
        angular.forEach($scope.tasks, function(task) {
          if (task.completed)
            completed += 1;
        });
        $scope.completed = completed;
      }
    }
  }
});
