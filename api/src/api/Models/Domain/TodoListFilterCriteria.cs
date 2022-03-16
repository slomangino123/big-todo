namespace api.Models.Domain
{
    public class TodoListFilterCriteria
    {
        public TodoListFilterCriteria(bool? isCompleted)
        {
            IsCompleted = isCompleted;
        }

        public bool? IsCompleted { get; private set; }
    }
}
