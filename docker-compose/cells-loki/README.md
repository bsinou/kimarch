# Simple setup with Promtail and Loki

This set-up is instrumnented with:

- Promtail
- Loki

## Requirements

It has to be installed on a machine that has:

- curl, jq
- systemd
- docker 
- docker-compose installed at `/usr/local/bin/docker-compose`

- docker loki plugin driver, see [the doc](https://grafana.com/docs/loki/latest/clients/docker-driver/)

```sh
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

## Deployment

From your workstation:

- Clone this repo
- Copy to `env` and adapt the `env-sample` file to fit to your needs and 
- Launch: `bash deploy.sh`

Then on the target server, as the running user (she must belong to `docker` group):

```sh
cd <your targetPath>/<your boxName>
docker-compose up -d mysql reverse loki
docker-compose up -d promtail cells; docker-compose logs -f 

# to distroy everything and try again:
docker-compose down -v --remove-orphan

```

You should be good to go.
