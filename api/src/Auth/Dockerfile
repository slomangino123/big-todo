#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base

# Copy certificates into the correct location for Debian 
ADD ./certificates/ca/certs/ca.crt /usr/local/share/ca-certificates/ca.crt
ADD ./certificates/ca/intermediate/certs/intermediate.crt /usr/local/share/ca-certificates/intermediate.crt
# Set owner of the file to have read and write access, and other users on the system to have read access
RUN chmod 644 /usr/local/share/ca-certificates/ca.crt \
    && chmod 644 /usr/local/share/ca-certificates/intermediate.crt \
    # Update the Debain certificate store to trust these certs
    && update-ca-certificates

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS restore
WORKDIR /src
COPY ["Auth/Auth.csproj", "Auth/"]
RUN dotnet restore "Auth/Auth.csproj"

FROM restore AS build
COPY . .
WORKDIR "/src/Auth"
RUN dotnet build "Auth.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Auth.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Auth.dll"]