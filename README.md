# Dockerit
[![Travis branch](https://img.shields.io/travis/com/I1820/Dockerit/master.svg?style=flat-square)](https://travis-ci.com/I1820/Dockerit)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9168e7dc29d14988b4cd631bf667449a)](https://www.codacy.com/app/i1820/Dockerit?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=I1820/Dockerit&amp;utm_campaign=Badge_Grade)

## Introduction
Run I1820 on dockers with no pain.

## Step by Step :baby:
These steps describe the procedure for running the dockerized version of I1820. You can build
each module from the source based on its readme.

1. Clone `Dockerit` repository.
```sh
git clone https://github.com/I1820/Dockerit && cd Dockerit
```

2. Start MongoDB database and configure its **replication** if you want. Please do not expose mongodb on `0.0.0.0` if your machine have public IP. Change remote ip binding in `mongodb/docker-compose.yml` with `remote_ip:remote_port:local_port`.
```sh
./start.sh mongodb up -d
```

3. Start RabbitMQ. Please do not expose it on `0.0.0.0` if your machine has public IP.
```sh
./start.sh rabbitmq up -d
```

4. Start Portainer and Prometheus. Please do not expose them on `0.0.0.0` if your machine has public IP.
```sh
./start.sh portainer up -d
./start.sh prometheus up -d
```

5. Start vernemq and configure its authentication handler's urls.
```sh
./start.sh vernemq up -d
```

6. Clone `pm` component repository.
```sh
git clone https://github.com/I1820/pm && cd pm
```

7. Create database indexes. Please note that you can create them manually and without grift.
```sh
buffalo task mongo
```

8. Run `runme.sh`
```sh
./runme.sh
```

9. Check `pm` configurations and run its docker. Please note that pm passes these configuration
to project's dockers so they must work there too.
```sh
./start.sh pm up -d
```

10. Check `link` configurations and run its docker.
```sh
./start.sh link up -d
```

11. Check `dm` configurations and run its docker.
```sh
./start.sh dm up -d
```

12. Clone `backend` component repository.
```sh
git clone https://github.com/I1820/backend && cd backend
```

13. Create database indexes. Please note that you can create them manually and without grift.
```sh
buffalo task mongo
```

14. Check `backend` configurations and run its docker.
```sh
./start.sh backend up -d
```


## I1820 Services
Please consider that in deployment you can change these ports with caution.

| Service          | Abbr  | Port     |
| ---------------- |:-----:| --------:|
| Project Manager  | pm    | 1375/tcp |
| Link             | link  | 1372/tcp |
| Data Manager     | dm    | 1373/tcp |
| Web Backend      | wb    | 1994/tcp |
| Web Frontend     | front | 1820/tcp |
| Weather Forecasting | wf | 6976/tcp |
