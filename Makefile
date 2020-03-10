#!make

include .env
export $(shell sed 's/=.*//' .env)

# Ansible
ANSIBLE = ansible-playbook
GALAXY = ansible-galaxy
ANS_ARGS = -k -K
DEPS = probakilla.apt_install

# files
MAIN = ansible/main.yml
TEST = ansible/test.yml

IMG_TAG = $(IMAGE_TAG)

all: install_dependencies install

rebuild: clean build run

build:
	docker build --no-cache -t $(IMG_TAG) .

run:
	docker run --tty --interactive $(IMG_TAG)

clean:
	docker image rm --force $(IMG_TAG)

install_dependencies:
	$(GALAXY) install $(DEPS)

install: $(MAIN)
	$(ANSIBLE) $(ANS_ARGS) $^

test: $(TEST)
	$(ANSIBLE) $^
