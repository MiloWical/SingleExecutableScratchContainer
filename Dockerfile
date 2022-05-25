FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine3.15 as base

# https://codevision.medium.com/docker-and-nativeaot-968096f17030
RUN apk update \
  && apk add ca-certificates \
  && apk add clang libexecinfo binutils musl-dev build-base zlib-static

FROM base as build

WORKDIR /_src
COPY * ./

RUN dotnet publish -p:Docker=true --self-contained -o /_bin -r linux-musl-x64

FROM scratch as runtime

WORKDIR /_app
COPY --from=build /_bin/single-file-webapp-test /_app/

CMD ["/_app/single-file-webapp-test"]