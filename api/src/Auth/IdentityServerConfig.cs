using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityServer4.DynamoDB.Data;
using IdentityServer4.Models;
using static IdentityServer4.IdentityServerConstants;

namespace Auth
{
    public static class IdentityServerConfig
    {
        public static void ConfigureData(this SeedDataBuilder builder)
        {
            builder.AddClient(client =>
            {
                client.ClientId = "console";
                client.ClientName = "Console Client Credentials";
                client.AllowedGrantTypes = GrantTypes.ClientCredentials;
                client.AllowedScopes = new string[] { "api", "todo.read" };
                client.ClientSecrets = new Secret[]
                {
                        new Secret("console".Sha256())
                };
            })
            .AddClient(client =>
            {
                client.ClientId = "flutter";
                client.AllowedGrantTypes = GrantTypes.Code;
                client.RequirePkce = true;
                client.RequireClientSecret = false;
                client.AllowAccessTokensViaBrowser = true;
                client.RedirectUris = new string[] { "http://localhost:4000/" };
                client.AllowedCorsOrigins = new string[] { "http://localhost:4000" };
                client.AllowedScopes = new string[] { StandardScopes.OpenId, StandardScopes.Profile, "todo.read", "todo.write", "todo.delete" };
            })
            .AddClient(client =>
            {
                client.ClientId = "swagger";
                client.AllowedGrantTypes = GrantTypes.Code;
                client.RequirePkce = true;
                client.RequireClientSecret = false;
                client.RedirectUris = new string[] { "http://10.0.0.102:7000/swagger/oauth2-redirect.html" };
                client.AllowedCorsOrigins = new string[] { "http://10.0.0.102:7000" };
                client.AllowedScopes = new string[] { StandardScopes.OpenId, StandardScopes.Profile, "todo.read", "todo.write", "todo.delete" };
            })
            .AddApiResource(apiResource =>
            {
                apiResource.Name = "todo";
                apiResource.DisplayName = "Todo API";
                apiResource.Scopes = new string[] { "todo.read", "todo.write", "todo.delete" };
            })
            .AddApiScope(scope =>
            {
                scope.Name = StandardScopes.OpenId;
                scope.DisplayName = StandardScopes.OpenId;
            })
            .AddApiScope(scope =>
            {
                scope.Name = StandardScopes.Profile;
                scope.DisplayName = StandardScopes.Profile;
            });
        }
    }
}
