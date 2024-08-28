# Makefile
# nlogs_sh

.DEFAULT_GOAL := help

help: ## Список команд
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make <commands> \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install: ## Установка
	@chmod u+x install.sh
	@./install.sh
