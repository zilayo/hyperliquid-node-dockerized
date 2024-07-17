.PHONY: start
start:
	@rm -rf "./node-data/*/*"
	@echo "Building & Running Hyperliquid Testnet node..."
	@DOCKER_BUILDKIT=1 docker compose build

	@echo "Node will start in 3 seconds."
	@echo "Once the node begins, logs can be checked with 'docker compose logs -f'"
	@echo "No logs are expected during normal operation - they will only appear if there is an error"	
	@echo "Use 'make stop' to stop the node"
	@sleep 3
	@docker compose up -d

.PHONY: stop
stop:
	@echo "Stopping the Hyperliquid Testnet node..."
	@docker compose stop