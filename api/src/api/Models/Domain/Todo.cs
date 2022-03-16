using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace api.Models.Domain
{
    public class Todo
    {
        public Guid Id { get; private set; }
        public string Title { get; private set; }
        public bool IsCompleted { get; set; }
        public DateTime? Completed { get; set; }
        public Todo(Guid id, string title)
        {
            Id = id;
            Title = title;
            IsCompleted = false;
            Completed = null;
        }
    }
}
