var todoList = {
  todos: [],

  addTodo: function (todoText) {
    this.todos.push({
      todoText: todoText,
      completed: false
    });
  },

  changeTodo: function (position, todoText) {
    this.todos[position].todoText = todoText;
  },

  deleteTodo: function (position) {
    this.todos.splice(position, 1);
  },

  toggleCompleted: function (position) {
    var todo = this.todos[position];
    todo.completed = !todo.completed;
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
  }

};

var handlers = {
  addTodo: function () {
    var addTodoTextInput = document.getElementById('addTodoTextInput');
    if (addTodoTextInput.value !== "") {
      todoList.addTodo(addTodoTextInput.value);
      addTodoTextInput.value = "";
    }
    view.displayTodos();
  },
  changeTodo: function () {
    var changeTodoTextInput = document.getElementById('changeTodoTextInput');
    var changeTodoPositionInput = document.getElementById('changeTodoPositionInput');
    if (changeTodoTextInput.value !== "") {
      todoList.changeTodo(changeTodoPositionInput.valueAsNumber, changeTodoTextInput.value);
      changeTodoTextInput.value = "";
      changeTodoPositionInput.value = "";
    }
    view.displayTodos();
  },
  deleteTodo: function () {
    var deleteTodoPositionInput = document.getElementById('deleteTodoPositionInput');
    todoList.deleteTodo(deleteTodoPositionInput.valueAsNumber);
    deleteTodoPositionInput.value = "";
    view.displayTodos();
  },
  toggleCompleted: function () {
    var toggleCompletedPositionInput = document.getElementById('toggleCompletedPositionInput');
    todoList.toggleCompleted(toggleCompletedPositionInput.valueAsNumber);
    toggleCompletedPositionInput.value = "";
    view.displayTodos();
  },
  toggleAll: function () {
    todoList.toggleAll();
    view.displayTodos();
  }
};

var view = {
  displayTodos: function () {
    var todosUl = document.querySelector('ul');
    todosUl.innerHTML = '';
    todoList.todos.forEach(function(todo){
      var todoLi = document.createElement('li');
      if (todo.completed) {
        todoLi.textContent = '(X) ';
      }
      else {
        todoLi.textContent = '( ) ';
      }
      todoLi.textContent += todo.todoText;
      todoLi.appendChild(this.createDeleteButton());      //change this.createDeleteButton() to view.createDeleteButton()
      todosUl.appendChild(todoLi);
    });
  },
  createDeleteButton: function () {
    var deleteButton = document.createElement('button');
    deleteButton.textContent = 'Delete';
    deleteButton.className = 'deleteButton';
    return deleteButton;
  }
};

// todoList.displayTodos();
// todoList.addTodo('item1');
// todoList.addTodo('item2');
// todoList.addTodo('item3');
// todoList.toggleAll();
// todoList.toggleAll();
// todoList.toggleCompleted(1);
// todoList.toggleAll();
