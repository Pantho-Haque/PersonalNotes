"use client";
import { action, computed, makeObservable, observable } from "mobx";

type TODO = {
  id: number;
  title: string;
  completed: boolean;
};

// function that stores all todos into local storage on browser
const saveToLocalStorage = (todos: TODO[]) => {
  if (typeof window !== "undefined") {
    localStorage.setItem("todos", JSON.stringify(todos));
  }
};

// function that gets all todos from local storage
const getFromLocalStorage = (): TODO[] => {
  if (typeof window !== "undefined") {
    const todos = localStorage.getItem("todos");
    return todos ? JSON.parse(todos) : [];
  }
  return [];
};

class TodoStore {
  todos: TODO[] = [];

  constructor() {
    this.todos = getFromLocalStorage();

    makeObservable(this, {
      todos: observable,
      addTodo: action,
      deleteTodo: action,
      toggleTodo: action,
      updateTodo: action,
      completedTodosLength: computed,
    });
    // or we can use makeAutoObservable(this)
  }

  // action
  addTodo = (todo: TODO) => {
    this.todos.push(todo);
    saveToLocalStorage(this.todos);
  };

  deleteTodo = (id: number) => {
    this.todos = this.todos.filter((todo) => todo.id !== id);
    saveToLocalStorage(this.todos);
  };

  updateTodo = (id: number, title: string) => {
    const todo = this.todos.find((todo) => todo.id === id);
    if (todo) {
      todo.title = title;
    }
    saveToLocalStorage(this.todos);
  };

  toggleTodo = (id: number) => {
    const todo = this.todos.find((todo) => todo.id === id);
    if (todo) {
      todo.completed = !todo.completed;
    }
    saveToLocalStorage(this.todos);
  };

  // computed
  get completedTodosLength() {
    return this.todos.filter((todo) => todo.completed).length;
  }
}

const todoStore = new TodoStore();
export default todoStore;



//runs immediately and on every change in the observable(completedTodosLength)
autorun(() => {
  console.log("todos:", todoStore.completedTodosLength);
});

//only runs when data() changes
reaction(
  // Data function - what to track
  () => todoStore.completedTodosLength,
  // Effect function - what to do
  (length, previousLength) => {
    console.log("todos changed from", previousLength, "to", length);
    if(length == todoStore.todos.length){
      alert("All todos are completed")
    }
  }
);

const Home = observer(() => {
  const [addingTodoText, setAddingTodoText] = useState("");
  return (
    <div className="flex flex-col items-center h-screen p-5">
      {/* heading of application  */}
      <h1>Todo App</h1>
      {/* adding new todo to our list  */}
      <div className="flex w-[50vw] mb-5 space-x-5">
        <Input
          type="text"
          placeholder="Enter your todo"
          className="w-full"
          value={addingTodoText}
          onChange={(e) => {
            setAddingTodoText(e.target.value);
          }}
        />
        <Button
          onClick={() => {
            todoStore.addTodo({
              id: Math.random(),
              title: addingTodoText,
              completed: false,
            });
            setAddingTodoText("");
          }}
        >
          Add Todo
        </Button>
      </div>

      {/* list view for the saved todo */}
      {todoStore.todos.length === 0 && <p>No todos</p>}
      {todoStore.todos.map((todo) => (
        <div
          key={todo.id}
          className="flex items-center justify-between w-96 p-2 border border-gray-200 rounded-md shadow-sm"
        >
          <Checkbox
            checked={todo.completed}
            onCheckedChange={() => todoStore.toggleTodo(todo.id)}
          />
          <p
            className={`text-start w-full pl-2 ${
              todo.completed ? "line-through" : ""
            }`}
          >
            {todo.title}
          </p>

          {/* settings */}
          <div className="flex space-x-2">
            <Button
              onClick={() => {
                const updatedTitle = prompt("Enter new title");
                if (updatedTitle) {
                  todoStore.updateTodo(todo.id, updatedTitle);
                }
              }}
            >
              <Edit />
            </Button>
            <Button onClick={() => todoStore.deleteTodo(todo.id)}>
              {" "}
              <Trash2 />{" "}
            </Button>
          </div>
        </div>
      ))}
    );
});