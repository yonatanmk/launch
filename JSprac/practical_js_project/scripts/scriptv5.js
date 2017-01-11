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
  }
};

todoList.displayTodos();
todoList.addTodo('item1');
todoList.addTodo('item2');
todoList.toggleCompleted(1);
