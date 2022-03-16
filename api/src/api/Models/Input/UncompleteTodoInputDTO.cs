using System;

namespace api.Models.Input
{
    public class UncompleteTodoInputDTO
    {
        public UncompleteTodoInputDTO(Guid id)
        {
            Id = id;
        }

        public Guid Id { get; private set; }
    }
}
