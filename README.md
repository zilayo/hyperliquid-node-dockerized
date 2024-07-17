# hyperliquid-node-dockerized

Docker container to run a Hyperliquid Testnet node.

## Instructions

Docker & Docker compose are required. See [https://docs.docker.com/engine/](https://docs.docker.com/engine/) for installation instructions.

- Ensure ports 8000 & 9000 are open to the public on your host machine.
- Run `git clone https://github.com/zilayo/hyperliquid-node-dockerized.git`
- Run `cd hyperliquid-node-dockerized`
- Run `make start`
- Logs can be viewed by running `docker compose logs --tail=10 -f`
- Data from the container will be mounted in this directory at ./node-data. Remove the volumes section from docker-compose if you don't require this.
- To stop the node, run `make stop`.
- Note - if the node is stopped, you must run `sudo make clean` before running `make start` again. Unfortunately sudo is currently required to delete logs due to underlying permissions set by the Hyperliquid binaries. To avoid this you can delete the volumes section entirely from the docker-compose.yml file

## Log cleanup

- Hyperliquid produces a lot of logs. To clean these run `./clean-logs.sh`
- This will delete all files/folders in ./node-data/log/ (/home/node/hl/data/log/ in the container) that are older than 3 days.
- Note: The cleanup script will only work if the docker compose file hasn't been modified.
