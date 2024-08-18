# Use the .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy the solution file
COPY Client/Client.sln ./Client/

# Copy project files
COPY Client/Client.csproj ./Client/
COPY Shared/Shared.csproj ./Shared/
COPY Server/Server.csproj ./Server/
COPY Domain/Domain.csproj ./Domain/
COPY Services/Services.csproj ./Services/
COPY Persistence/Persistence.csproj ./Persistence/

# Restore dependencies
RUN dotnet restore ./Client/Client.sln

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish ./Client/Client.sln -c Release -o out

# Use the ASP.NET runtime image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Client.dll"]
