#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

# # Copy certificates into the correct location for Debian 
# ADD ./certificates/ca/certs/ca.crt /usr/local/share/ca-certificates/ca.crt
# ADD ./certificates/ca/intermediate/certs/intermediate.crt /usr/local/share/ca-certificates/intermediate.crt
# # Set owner of the file to have read and write access, and other users on the system to have read access
# RUN chmod 644 /usr/local/share/ca-certificates/ca.crt \
#     && chmod 644 /usr/local/share/ca-certificates/intermediate.crt \
#     # Update the Debain certificate store to trust these certs
#     && update-ca-certificates

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
COPY ["api/src/api/api.csproj", "api/src/api/"]
RUN dotnet restore "api/src/api/api.csproj"
COPY . .
WORKDIR "api/src/api"
RUN dotnet build "api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "api.dll"]

# docker build -t api:latest -f api/src/api/Dockerfile .