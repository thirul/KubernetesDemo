FROM mcr.microsoft.com/dotnet/core/sdk:2.1 as builder
WORKDIR /src
COPY ./kubedemo.csproj .
RUN dotnet restore kubedemo.csproj
COPY . .
RUN dotnet build kubedemo.csproj -c debug -o /src/out

FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 
WORKDIR /app
COPY --from=builder /src/out .

EXPOSE 80
ENTRYPOINT ["dotnet", "kubedemo.dll"]


# docker build . -t thirul/kubedemo:0.0.2
# run docker image: docker run -it -p 8081:80 kubedemo:0.0.1