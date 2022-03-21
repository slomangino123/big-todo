using Amazon.DynamoDBv2;
using Auth.Configuration.Options;
using Auth.Data;
using Auth.Services;
using IdentityServer4.DynamoDB.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Logging;

namespace Auth
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        public IWebHostEnvironment Environment { get; }

        public Startup(IConfiguration configuration, IWebHostEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            IdentityModelEventSource.ShowPII = true;

            var todoApiOptionsConfigSection = Configuration.GetSection(TodoApiOptions.Section);
            var todoApiOptions = new TodoApiOptions();
            todoApiOptionsConfigSection.Bind(todoApiOptions);
            services.Configure<TodoApiOptions>(todoApiOptionsConfigSection);

            services.AddDbContext<AppIdentityDbContext>(config =>
            {
                config.UseInMemoryDatabase("Memory");
            });

            services.AddIdentity<IdentityUser, IdentityRole>(config =>
            {
                config.Password.RequiredLength = 4;
                config.Password.RequireDigit = false;
                config.Password.RequireNonAlphanumeric = false;
                config.Password.RequireUppercase = false;
            })
                .AddEntityFrameworkStores<AppIdentityDbContext>()
                .AddDefaultTokenProviders();

            services.ConfigureApplicationCookie(config =>
            {
                config.Cookie.Name = "IdentityServer.Cookie";
                config.LoginPath = "/Auth/Login";
            });

            services.AddTransient<SeedDataRunner>();
            services.RegisterDynamoDbSeedData(x => x.ConfigureData(todoApiOptions));

            services.AddDefaultAWSOptions(Configuration.GetAWSOptions());

            var identityServerBuilder = services.AddIdentityServer()
                .AddAspNetIdentity<IdentityUser>()
                .AddDeveloperSigningCredential()
                .AddConfigurationStore(options =>
                {
                    options.AmazonDynamoDbConfig = new AmazonDynamoDBConfig();
                    if (Environment.IsDevelopment())
                    {
                        options.AmazonDynamoDbConfig.ServiceURL = "http://localhost:8000";
                    }
                })
                .AddProfileService<IdentityProfileService>();

            //services.AddIdentityServer()
            //    .AddAspNetIdentity<IdentityUser>()
            //    .AddDeveloperSigningCredential()
            //    .AddInMemoryClients(IdentityServerInMemoryConfig.GetClients())
            //    .AddInMemoryApiScopes(IdentityServerInMemoryConfig.GetApiScopes())
            //    .AddInMemoryIdentityResources(Enumerable.Empty<IdentityResource>())
            //    .AddInMemoryApiResources(IdentityServerInMemoryConfig.GetApiResources())
            //    .AddProfileService<IdentityProfileService>();

            services.AddControllersWithViews();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            var todoApiOptions = app.ApplicationServices
                .GetRequiredService<IOptions<TodoApiOptions>>()
                .Value;

            app.UseCors(policy =>
            {
                policy.AllowAnyMethod();
                policy.AllowAnyHeader();
                policy.WithOrigins(todoApiOptions.Address);
            });

            app.UseRouting();

            app.UseIdentityServer();

            //app.UseHttpsRedirection();

            //app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
