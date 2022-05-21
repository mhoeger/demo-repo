.DEFAULT_GOAL := help

DEV_COMPOSE = docker-compose
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1


.PHONY: run ## Run app devbox :)
run:
	$(DEV_COMPOSE) -f docker-compose.common.yml run  --rm devbox

.PHONY: down ## Spin down the running container
down:
	$(DEV_COMPOSE) -f docker-compose.common.yml down

.PHONY: test ## Run app test suite
test:
ifeq ($(IS_DEV_CONTAINER_ENV), true)
	./docker/run_tests.sh --project-dir test --local --unit-test --run pytest tests/unit/* --cov-fail-under=1 --cov-report=html:.pytest_reports/html_dir --cov-report=xml:.pytest_reports/coverage.xml
else
	$(DEV_COMPOSE) -f docker-compose.common.yml run test
endif

.PHONY: lint ## Run app linting tools
lint:
ifeq ($(IS_DEV_CONTAINER_ENV), true)
	./docker/run_tests.sh --local --lint --project-dir test
else
	$(DEV_COMPOSE) -f docker-compose.common.yml run lint
endif

##############################################################################
# HELPERS
##############################################################################
.PHONY: help  ## display the list of available make commands
help:
	@grep -E \
		'^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ".PHONY: |## "}; {printf "\033[36m%-20s\033[0m %s\n", $$2, $$3}'

.PHONY: install-requirements ## install existing requirements.txt
install-requirements:
	pip3 install \
    -r requirements.txt \
    --trusted-host infra-pypicloud.prod.pachama.com \
    --index-url https://infra-pypicloud.prod.pachama.com/simple/

.PHONY: install-requirements ## install existing requirements-test.txt
install-test-requirements:
	pip3 install \
    -r requirements-test.txt \
    --trusted-host infra-pypicloud.prod.pachama.com \
    --index-url https://infra-pypicloud.prod.pachama.com/simple/

.PHONY: install ## install all required packages
install:
	$(MAKE) install-requirements
	$(MAKE) install-test-requirements

.PHONY: lock-requirements ## Generate a requirements.txt file from requirements.in
lock-requirements:
	pip-compile requirements.in

.PHONY: lock-test-requirements ## Generate a requirements-test.txt file from requirements-test.in
lock-test-requirements:
	pip-compile requirements-test.in

.PHONY: lock ## locks both requirements.in and requirements-test.in
lock:
	$(MAKE) lock-requirements
	$(MAKE) lock-test-requirements

.PHONY: add ## Add pip packages to requirements.in and compile to requirements.txt, then install
add:
	echo "$(call packages,'')" | tr " " "\n" >> requirements.in
	$(MAKE) lock-requirements
	$(MAKE) install-requirements

.PHONY: add-test ## Add pip packages to requirements-test.in and compile to requirements-test.txt, then install
add-test:
	echo "$(call packages,'')" | tr " " "\n" >> requirements-test.in
	$(MAKE) lock-test-requirements
	$(MAKE) install-test-requirements

.PHONY: setup
setup:
	$(MAKE) install
	pre-commit install
