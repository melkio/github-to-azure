FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

COPY *.sln .
COPY src/ ./src/

RUN dotnet restore 
RUN dotnet publish src/GitHubToAzure/GitHubToAzure.csproj -o ./out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "GitHubToAzure.dll"]