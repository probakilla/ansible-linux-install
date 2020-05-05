#!make

include .env
export $(shell sed 's/=.*//' .env)

# Ansible
ANSIBLE = ansible-playbook
GALAXY = ansible-galaxy
ANS_ARGS = -kK

IMG_TAG = $(IMAGE_TAG)

all: install-deps install

rebuild: clean build run

build:
	docker build --no-cache -t $(IMG_TAG) .

run:
	docker run --tty --interactive $(IMG_TAG)

clean:
	docker image rm --force $(IMG_TAG)

install-deps:
	$(GALAXY) install -r requirements.yml

install:
	$(ANSIBLE) install.yml -k -K

update:
	$(ANSIBLE) update.yml -k -K
