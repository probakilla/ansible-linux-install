#!make

include .env
export $(shell sed 's/=.*//' .env)

IMG_TAG = $(IMAGE_TAG)

all: build

rebuild: clean build

build:
	docker build --no-cache -t $(IMG_TAG) .

run:
	docker run --tty --interactive $(IMG_TAG)

clean:
	docker image rm --force $(IMG_TAG)

test:
	ansible-playbook tasks/test.yml

ansible:
	ansible-playbook tasks/main.yml
