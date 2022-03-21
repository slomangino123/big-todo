using System;
using System.Collections.Generic;
using api.Configuration;
using api.Configuration.Options;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Logging;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

namespace api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            IdentityModelEventSource.ShowPII = true;

            var authoptions = new AuthOptions();
            Configuration.GetSection(AuthOptions.Section).Bind(authoptions);

            services.AddControllers();

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
                {
                    options.RequireHttpsMetadata = false;
                    options.Authority = authoptions.Address;
                    options.Audience = "todo";

                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidIssuers = new string[]
                        {
                           "http://localhost:5000",
                           authoptions.Address,
                        },
                        ValidateAudience = true,
                        ValidateIssuer = true,
                    };
                });

            services.AddAuthorization(options =>
            {
                options.AddPolicy("write", policy =>
                {
                    policy.RequireAuthenticatedUser();
                    policy.RequireClaim("scope", "todo.write");
                });
                options.AddPolicy("read", policy =>
                {
                    policy.RequireAuthenticatedUser();
                    policy.RequireClaim("scope", "todo.read");
                });
            });

            services.AddSwaggerGen(c =>
            {
                c.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
                {
                    Type = SecuritySchemeType.OAuth2,
                    Flows = new OpenApiOAuthFlows
                    {
                        AuthorizationCode = new OpenApiOAuthFlow
                        {
                            AuthorizationUrl = new Uri($"{authoptions.Address}/connect/authorize", UriKind.Absolute),
                            TokenUrl = new Uri($"{authoptions.Address}/connect/token", UriKind.Absolute),
                            Scopes = new Dictionary<string, string>
                            {
                                { "todo.read", "read todos" },
                                { "todo.write", "write todos" },
                                { "todo.delete", "delete todos" }
                            },
                        }
                    }
                });

                c.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = "oauth2"
                            }
                        },
                        new[] { "todo.read" }
                    }
                });
            });

            services.AddTodoDomainServices();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();

            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
                c.OAuthClientId("swagger");
                c.OAuthScopeSeparator(" ");
                c.OAuthUsePkce();
            });

            //app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
