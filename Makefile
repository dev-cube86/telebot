APP_VERSION=$(shell git describe --tags)-$(shell git rev-parse --short HEAD)

format:
	gofmt -s -w ./
lint:
	go lint
test:

get:
	go get	
build:
	go build -v -o telebot -ldflags "-X="github.com/dev-cube86/telebot/cmd.appVersion=${APP_VERSION}
image:
	docker build .
	docker tag -t 
push:

clean:
