FROM golang:alpine3.16 as build

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY . .

RUN go mod download \
  && go build
### End build


FROM alpine:3.16.3

ENV APP_HOME /app
WORKDIR $APP_HOME

ENV APP_USER=stackio
ENV APP_GROUP=stackio
RUN adduser -D $APP_USER

USER $APP_USER

COPY --from=build --chown=${APP_USER}:${APP_GROUP} ${APP_HOME}/dockerize .
COPY --chown=${APP_USER}:${APP_GROUP} ./src .

EXPOSE 8080

CMD [ "./dockerize" ]
