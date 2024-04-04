#!/usr/bin/env bash

platforms=("windows/amd64" "windows/386" "darwin/amd64")

for platform in "${platforms[@]}"
do
	platform_split=(${platform//\// })
	GOOS=${platform_split[0]}
	GOARCH=${platform_split[1]}

    if [ $GOOS = "windows" ]; then
		output_name+='.exe'
	fi	

	env CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH go build -v -o telebot -ldflags "-X="github.com/dev-cube86/telebot/cmd.appVersion=${VERSION}
done    