namespace api.Models.Input
{
    public class ListTodosInputDTO
    {
        public ListTodosInputDTO(bool? isCompleted)
        {
            IsCompleted = isCompleted;
        }

        public bool? IsCompleted { get; private set; }
    }
}
