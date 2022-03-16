using System;

namespace api.Models.Input
{
    public class CompleteTodoInputDTO
    {
        public CompleteTodoInputDTO(Guid id)
        {
            Id = id;
        }

        public Guid Id { get; private set; }
    }
}
