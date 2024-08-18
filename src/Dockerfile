# Use the .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy the solution file and project files
COPY Client/Client.sln ./Client/
COPY Client/*.csproj ./Client/
RUN dotnet restore ./Client/Client.sln

# Restore dependencies for the solution
RUN dotnet restore ./Client/Client.sln

# Copy the rest of the application code and build
COPY . ./
RUN dotnet publish -c Release -o out

# Use the ASP.NET runtime image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Client.dll"]
