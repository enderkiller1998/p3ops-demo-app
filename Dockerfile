# Use the official .NET 6 SDK image as a build environment
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . ./

# Restore the NuGet packages
RUN dotnet restore src/Server/Server.csproj

# Build the application
RUN dotnet build src/Server/Server.csproj --no-restore

# Publish the application as self-contained
RUN dotnet publish src/Server/Server.csproj -c Release -o publish

# Use the official .NET 6 runtime image for the final build
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory in the final container
WORKDIR /app

# Copy the published files from the build environment
COPY --from=build-env /app/publish .

# Set environment variables
ENV DOTNET_ENVIRONMENT=Production \
    DOTNET_ConnectionStrings__SqlDatabase="Server=172.17.0.2,1433;Database=sporthal;User Id=sa;Password=Administrator123!;"

# Expose the port the app runs on
EXPOSE 8080

# Start the server
ENTRYPOINT ["dotnet", "Server.dll"]
