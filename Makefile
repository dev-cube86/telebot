VERSION=$(shell git describe --tags --abbrev=0 main)-$(shell git rev-parse --short HEAD)
REGISTRY=gcr.io/devops-training-419011
APP_NAME=$(shell basename $(shell git remote get-url origin))
TARGETOS=linux
TARGETARCH=x86_64

format:
	gofmt -s -w ./
lint:
	golint
test:
	go test -v
get:
	go get	
build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o telebot -ldflags "-X="github.com/dev-cube86/telebot/cmd.appVersion=${VERSION}
image:
	docker build . -t ${REGISTRY}/${APP_NAME}:${VERSION}-${TARGETARCH}
push:
	docker push ${REGISTRY}/${APP_NAME}:${VERSION}-${TARGETARCH}
clean:
	docker rmi ${REGISTRY}/${APP_NAME}:${VERSION}-${TARGETARCH}
