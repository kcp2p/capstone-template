SHELL := /bin/bash

.PHONY: build watch clean shell image

build:
	./build.sh build

watch:
	./build.sh watch

clean:
	./build.sh clean

shell:
	./build.sh shell

image:
	./build.sh rebuild-image
