# Dockerit
[![Travis branch](https://img.shields.io/travis/com/I1820/Dockerit/master.svg?style=flat-square)](https://travis-ci.com/I1820/Dockerit)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9168e7dc29d14988b4cd631bf667449a)](https://www.codacy.com/app/i1820/Dockerit?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=I1820/Dockerit&amp;utm_campaign=Badge_Grade)

## Introduction
Run I1820 on dockers with no pain.
I1820 works with LoRa and LAN protocol
so run them by your choices.

## I1820 Services

| Service          | Abbr  | Port     |
| ---------------- |:-----:| --------:|
| Project Manager  | pm    | 1375/tcp |
| Link             | link  | 1372/tcp |
| Data Manager     | dm    | 1373/tcp |

## MQTT Link
I1820 support many protocols like lan and lora,
These protocols send and receive data using mqtt.

## LoRa Server Docker setup

| Service          | Port     |
| ---------------- | --------:|
| App Server       | 7070/tcp |
| Gateway Bridge   | 1700/udp |


This repository contains a skeleton to setup the [LoRa Server](https://www.loraserver.io)
project using [docker-compose](https://docs.docker.com/compose/).

**Note:** Please use this `docker-compose.yml` file as a starting point for testing
but keep in mind that for production usage it might need modifications. 

### Directory layout

* `docker-compose.yml`: the docker-compose file containing the services
* `configuration/lora*`: directory containing the LoRa Server configuration files, see:
    * https://www.loraserver.io/lora-gateway-bridge/install/config/
    * https://www.loraserver.io/loraserver/install/config/
    * https://www.loraserver.io/lora-app-server/install/config/
* `configuration/postgresql/initdb/`: directory containing PostgreSQL initialization scripts
* `data/postgresql`: directory containing the PostgreSQL data (auto-created)
* `data/redis`: directory containing the Redis data (auto-created)

### Configuration

The LoRa Server components are pre-configured to work with the provided
`docker-compose.yml` file and defaults to the EU868 LoRaWAN band. Please refer
to the `configuration/loraserver/loraserver.toml` configuration file to
configure a different band.

### Requirements

Before using this `docker-compose.yml` file, make sure you have [Docker](https://www.docker.com/community-edition)
installed.

### Usage

To start all the LoRa Server components, simply run:

```bash
$ docker-compose up
```

After all the components have been initialized and started, you should be able
to open https://localhost:8080/ in your browser. As the certificates under the
`configuration/lora-app-server/certs` are self-signed, this will raise a warning.

#### Add network-server

When adding the network-server in the LoRa App Server web-interface
(see [network-servers](https://www.loraserver.io/lora-app-server/use/network-servers/)),
you must enter `loraserver:8000` as the network-server `hostname:IP`.
