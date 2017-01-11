var todoList = {
  todos: ['item1', 'item2', 'item3'],
  displayTodos: function() {
    console.log(this.todos);
  },

  addTodo: function (todo) {
  this.todos.push(todo);
  this.displayTodos();
  },

  changeTodo: function (position, newValue) {
    this.todos[position] = newValue;
    this.displayTodos();
  },

  deleteTodo: function (position) {
    this.todos.splice(position, 1);
    this.displayTodos();
  }
};

todoList.addTodo('item4');
todoList.changeTodo(1, 'newValue');
todoList.deleteTodo(1);
