################################################################################
# AD-SDL WEI Makefile
################################################################################
.DEFAULT_GOAL := init

.PHONY += init paths checks test clean

init: # Do the initial configuration of the project
	@test -e .env || cp example.env .env
ifeq ($(shell uname),Darwin)
	@sed -i '' 's/^PROJECT_DIR=.*/PROJECT_DIR=$(shell pwd | sed 's/\//\\\//g')/' .env
	@sed -i '' 's/^USER_ID=.*/USER_ID=1000/' .env
	@sed -i '' 's/^GROUP_ID=.*/GROUP_ID=1000/' .env
else
	@sed -i 's/^PROJECT_DIR=.*/PROJECT_DIR=$(shell pwd | sed 's/\//\\\//g')/' .env
	@sed -i 's/^USER_ID=.*/USER_ID=$(shell id -u)/' .env
	@sed -i 's/^GROUP_ID=.*/GROUP_ID=$(shell id -g)/' .env
endif


.env: init

paths: .env # Create the necessary data directories
	@mkdir -p $(shell grep -E '^WEI_DATA_DIR=' .env | cut -d '=' -f 2)
	@mkdir -p $(shell grep -E '^REDIS_DIR=' .env | cut -d '=' -f 2)

checks: # Runs all the pre-commit checks
	@pre-commit install
	@pre-commit run --all-files || { echo "Checking fixes\n" ; pre-commit run --all-files; }

test: init .env paths # Runs all the tests
	@docker compose up --build -d
	@docker compose down

clean:
	@rm .env

build: # Builds the project
	@docker compose build
