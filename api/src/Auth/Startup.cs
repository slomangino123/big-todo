using System.Linq;
using Amazon.DynamoDBv2;
using Auth.Data;
using Auth.Services;
using IdentityServer4.DynamoDB.Data;
using IdentityServer4.Models;
using IdentityServer4.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Logging;
using Amazon.Extensions.NETCore.Setup;
using static IdentityServer4.IdentityServerConstants;

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
            services.RegisterDynamoDbSeedData(x => x.ConfigureData());

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

            app.UseCors(policy =>
            {
                policy.AllowAnyMethod();
                policy.AllowAnyHeader();
                policy.WithOrigins("http://10.0.0.102:7000");
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
