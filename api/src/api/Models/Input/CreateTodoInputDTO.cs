using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Models.Input
{
    public class CreateTodoInputDTO
    {
        public string Title { get; private set; }
        public CreateTodoInputDTO(string title)
        {
            Title = title;
        }
    }
}
