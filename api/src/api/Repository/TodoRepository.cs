using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using api.Models.Domain;
using api.Models.Input;

namespace api.Repository
{
    public class TodoRepository
    {
        private ICollection<Todo> Todos = new List<Todo>();
        public Task CreateTodo(CreateTodoInputDTO input, CancellationToken ct)
        {
            var todo = new Todo(Guid.NewGuid(), input.Title);
            Todos.Add(todo);
            return Task.CompletedTask;
        }

        public Task<IEnumerable<Todo>> ListTodos(TodoListFilterCriteria filter, CancellationToken ct)
        {
            if (filter.IsCompleted == false)
            {
                return Task.FromResult<IEnumerable<Todo>>(Todos.Where(x => x.IsCompleted == false));
            }

            if (filter.IsCompleted == true)
            {
                return Task.FromResult<IEnumerable<Todo>>(Todos.Where(x => x.IsCompleted == true).OrderByDescending(x => x.Completed));
            }

            return Task.FromResult<IEnumerable<Todo>>(Todos);
        }

        public Task CompleteTodo(Guid id, CancellationToken ct)
        {
            var todo = Todos.First(x => x.Id == id);
            if (todo.IsCompleted)
            {
                return Task.CompletedTask;
            }

            todo.IsCompleted = true;
            todo.Completed = DateTime.UtcNow;
            return Task.CompletedTask;
        }

        public Task UncompleteTodo(Guid id, CancellationToken ct)
        {
            var todo = Todos.First(x => x.Id == id);

            todo.IsCompleted = false;
            todo.Completed = null;
            return Task.CompletedTask;
        }
    }
}
