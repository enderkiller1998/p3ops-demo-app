FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /App
COPY . ./
RUN dotnet publish src/Server/Server.csproj -c Release -o out
RUN dotnet test tests/Domain.Tests/Domain.Tests.csproj

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "Server.dll"]
