using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Repository;
using Microsoft.Extensions.DependencyInjection;

namespace api.Configuration
{
    public static class DomainConfigurationExtensions
    {
        public static IServiceCollection AddTodoDomainServices(this IServiceCollection services)
        {
            services.AddSingleton<TodoRepository>();
            return services;
        }
    }
}
