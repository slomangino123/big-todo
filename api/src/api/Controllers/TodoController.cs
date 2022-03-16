using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using api.Models.Domain;
using api.Models.Input;
using api.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    [Authorize]
    public class TodoController : ControllerBase
    {
        private readonly TodoRepository _repository;

        public TodoController(TodoRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        [Authorize("write")]
        public async Task<IActionResult> Create([FromBody] CreateTodoInputDTO input, CancellationToken ct)
        {
            await _repository.CreateTodo(input, ct);
            return Ok();
        }

        [HttpGet]
        [Authorize("read")]
        public async Task<ActionResult<IEnumerable<Todo>>> List(ListTodosInputDTO input, CancellationToken ct)
        {
            var result = await _repository.ListTodos(new TodoListFilterCriteria(input.IsCompleted), ct);
            return Ok(result);
        }

        [HttpPut]
        [Authorize("write")]
        public async Task<ActionResult<IEnumerable<Todo>>> Complete(CompleteTodoInputDTO input, CancellationToken ct)
        {
            await _repository.CompleteTodo(input.Id, ct);
            return Ok();
        }

        [HttpPut]
        [Authorize("write")]
        public async Task<ActionResult<IEnumerable<Todo>>> Uncomplete(UncompleteTodoInputDTO input, CancellationToken ct)
        {
            await _repository.UncompleteTodo(input.Id, ct);
            return Ok();
        }
    }
}
