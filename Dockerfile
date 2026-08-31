# first-stage base image
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source

COPY *.csproj .

RUN dotnet restore dockerapp.csproj

# copy and publish application file

COPY . .
RUN dotnet publish dockerapp.csproj -c release -o /app

# final stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0

WORKDIR /app
COPY --from=build /app .

ENTRYPOINT [ "dotnet",  "dockerapp.dll"]
