# Cells Enterprise Distribution

This example is known to work but provided WITHOUT ANY GUARANTY

## Overview

This sets up an environment that contains:

- Pydio Cells Enterprise distribution (a license key is necessary)
- Traefik as reverse proxy, with dashboard enabled at ${PUBLIC_FQDN}/dashboard/
- A MySQL database
- Prometheus to gather and export metrics under ${PUBLIC_FQDN}/prometheus"

## Various Notes

- TLS is provided by Let's Encrypt (using Staging CA URL by default) for both Cells and the Traefik dashboard
- In the server, where the `docker-compose.yml` file resides:
  - The setup expected a `.env` file that contains mainly credentials  (see `.env.sample` for expected properties)
  - Before first start or when switching from _staging_ to _production_ CA server, you must insure an **empty** file with correct permission has been created: `touch acme.json; chmod 600 acme.json`
