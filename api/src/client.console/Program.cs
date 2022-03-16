using System;
using System.Net.Http;
using System.Threading.Tasks;
using IdentityModel.Client;
using Microsoft.IdentityModel.Logging;
using Newtonsoft.Json.Linq;

namespace client
{
    public class Program
    {
        public static string API_BASE_URL = "http://10.0.0.102:6000";
        public static string AUTH_BASE_URL = "http://10.0.0.102:5000";
        public static async Task Main(string[] args)
        {

            IdentityModelEventSource.ShowPII = true;

            Console.WriteLine("Press 1-? to make service call");
            while (true)
            {
                var input = Console.ReadKey();
                if (input.Key == ConsoleKey.D1)
                {
                    await ServiceCall();
                }
            }
        }

        public static async Task ServiceCall()
        {
            var client = new HttpClient();
            var disco = await client.GetDiscoveryDocumentAsync(
                new DiscoveryDocumentRequest()
                {
                    Address = AUTH_BASE_URL,
                    Policy =
                    {
                        RequireHttps = false,
                    },
                });

            if (disco.IsError)
            {
                Console.WriteLine(disco.Error);
                return;
            }

            var tokenResponse = await client.RequestClientCredentialsTokenAsync(
                new ClientCredentialsTokenRequest
                {
                    Address = disco.TokenEndpoint,

                    ClientId = "console",
                    ClientSecret = "console",
                    Scope = "api todo.read",
                });

            if (tokenResponse.IsError)
            {
                Console.WriteLine(tokenResponse.Error);
                return;
            }

            Console.WriteLine(tokenResponse.Json);

            var apiClient = new HttpClient();
            apiClient.SetBearerToken(tokenResponse.AccessToken);

            var response = await apiClient.GetAsync($"{API_BASE_URL}/health/identity");

            if (!response.IsSuccessStatusCode)
            {
                Console.WriteLine(response.StatusCode);
            }
            else
            {
                var content = await response.Content.ReadAsStringAsync();
                Console.WriteLine(JArray.Parse(content));
            }
        }
    }
}
