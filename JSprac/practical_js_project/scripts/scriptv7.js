var todoList = {
  todos: [],
  displayTodos: function() {
    if (this.todos.length === 0) {
      console.log('Your todo list is empty');
    }
    else {
      console.log('My todos:');
      this.todos.forEach(function (todo) {
        if (todo.completed) {
          console.log('(X) ' + todo.todoText);
        }
        else {
          console.log('( ) ' + todo.todoText);
        }
      });
    }
  },

  addTodo: function (todoText) {
    this.todos.push({
      todoText: todoText,
      completed: false
    });
    this.displayTodos();
  },

  changeTodo: function (position, todoText) {
    this.todos[position].todoText = todoText;
    this.displayTodos();
  },

  deleteTodo: function (position) {
    this.todos.splice(position, 1);
    this.displayTodos();
  },

  toggleCompleted: function (position) {
    var todo = this.todos[position];
    todo.completed = !todo.completed;
    this.displayTodos();
  },

  allCompleted: function () {
    var output = true;
    this.todos.forEach(function(todo){
      if (!todo.completed) {
        output = false;
      }
    });
    return output;
  },

  toggleAll: function () {
    var allComplete = this.allCompleted();
    this.todos.forEach (function (todo) {
      todo.completed = !allComplete;
    });
    this.displayTodos();
  }


};

var displayTodosButton = document.getElementById('displayTodosButton');
displayTodosButton.addEventListener('click', function () {
  todoList.displayTodos();
});

var toggleAllButton = document.getElementById('toggleAllButton');
toggleAllButton.addEventListener('click', function () {
  todoList.toggleAll();
});

// todoList.displayTodos();
todoList.addTodo('item1');
todoList.addTodo('item2');
todoList.addTodo('item3');
// todoList.toggleAll();
// todoList.toggleAll();
// todoList.toggleCompleted(1);
// todoList.toggleAll();
