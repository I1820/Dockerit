# Dockerit
[![Travis branch](https://img.shields.io/travis/com/I1820/Dockerit/master.svg?style=flat-square)](https://travis-ci.com/I1820/Dockerit)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9168e7dc29d14988b4cd631bf667449a)](https://www.codacy.com/app/i1820/Dockerit?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=I1820/Dockerit&amp;utm_campaign=Badge_Grade)

## Introduction
Run I1820 on dockers with no pain.

## Step by Step :baby:
1. Clone
```sh
git clone https://github.com/I1820/Dockerit
```
2. Start MongoDB database and configure its replication if you want.
```sh
./start.sh mongodb
```
3. Start Portainer and Prometheus.
```sh
./start.sh portainer
./start.sh prometheus
```
4. Clone `pm` component repository
```sh
git clone https://github.com/I1820/pm
```
5. Create database indexes and run `runme.sh` in `pm`.
6. Check `pm` configuration and run its docker.
```sh
./start.sh pm
```
7. Check `link` configuration and run its docker.
```sh
./start.sh link
```

## I1820 Services
Please consider that in deployment you can change these ports.

| Service          | Abbr  | Port     |
| ---------------- |:-----:| --------:|
| Project Manager  | pm    | 1375/tcp |
| Link             | link  | 1372/tcp |
| Data Manager     | dm    | 1373/tcp |
| WebBackend       | wb    | 1994/tcp |
