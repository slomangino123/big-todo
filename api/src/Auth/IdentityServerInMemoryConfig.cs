using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityServer4.DynamoDB.Data;
using IdentityServer4.Models;
using static IdentityServer4.IdentityServerConstants;

namespace Auth
{
    public static class IdentityServerInMemoryConfig
    {
        public static IEnumerable<Client> GetClients()
        {
            return new List<Client>
            {
                new Client
                {
                    ClientId = "console",
                    ClientName = "Console Client Credentials",
                    AllowedGrantTypes = GrantTypes.ClientCredentials,
                    AllowedScopes = new string[] { "api", "todo.read" },
                    ClientSecrets = new Secret[]
                    {
                        new Secret("console".Sha256())
                    },
                }
            };
        }

        public static IEnumerable<ApiScope> GetApiScopes()
        {
            return new List<ApiScope>
            {
                new ApiScope("api"),
                new ApiScope("todo.read"),
                new ApiScope("todo.write"),
                new ApiScope(StandardScopes.OpenId),
                new ApiScope(StandardScopes.Profile),
            };
        }

        public static IEnumerable<ApiResource> GetApiResources()
        {
            return new List<ApiResource>
            {
                new ApiResource("todo")
                {
                    Scopes = new string[]{ "todo.read", "todo.write" },
                },
            };
        }
    }
}
