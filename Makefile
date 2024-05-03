# VERSION=$(shell git describe --tags --abbrev=0 main)-$(shell git rev-parse --short HEAD)
# REGISTRY=gcr.io/devops-training-419011
REGISTRY=ghcr.io/dev-cube86
APP_NAME=$(shell basename $(shell git remote get-url origin))
TARGETOS1=linux
TARGETOS2=windows
TARGETOS3=ios
TARGETARCH1=amd64
TARGETARCH2=386
TARGETARCH3=arm64
TARGETARCH4=arm
build = CGO_ENABLED=0 GOOS=$(1) GOARCH=$(2) go build -v -o telebot -ldflags "-X="github.com/dev-cube86/telebot/cmd.appVersion=${VERSION}

format:
	gofmt -s -w ./
lint:
	golint
test:
	go test -v
get:
	go get
build:
	$(call build,${OS},${ARCH},)
# linux: format get
# 	$(call build,${TARGETOS1},${TARGETARCH1},)
# windows: format get
# 	$(call build,${TARGETOS2},${TARGETARCH2},.exe)
# ios: format get
# 	$(call build,${TARGETOS3},${TARGETARCH3},)
image: 
	docker build -t ${REGISTRY}/${APP_NAME}:${VERSION}-${OS}-${ARCH} --build-arg TARGETOS=${TARGETOS1} .
push:
	docker push ${REGISTRY}/${APP_NAME}:${VERSION}-${OS}-${ARCH}
clean:
	docker rmi ${REGISTRY}/${APP_NAME}:${VERSION}-${TARGETOS1}-${TARGETARCH1}
