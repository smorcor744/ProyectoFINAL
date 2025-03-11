# Usa la imagen de .NET 8 SDK para construir la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia el archivo del proyecto y restaura las dependencias
COPY ApiGame.csproj .
RUN dotnet restore

# Copia el resto de los archivos y construye la aplicación
COPY . .
RUN dotnet publish -c Release -o /app

# Usa la imagen de .NET 8 Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia los archivos publicados desde la etapa de construcción
COPY --from=build /app .

# Expone el puerto 80
EXPOSE 80

# Define la URL para que la aplicación escuche en todas las interfaces de red
ENV ASPNETCORE_URLS=http://0.0.0.0:80

# Define el comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "ApiGame.dll"]