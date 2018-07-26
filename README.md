# docker-nodejs-ionic
Node.js development environment with Ionic, Cordova, PostgreSQL and Docker.

Uses Node.js 8.x and latest versions of Ionic, Cordova, PostgreSQL and Docker.

The USB port is mapped to container.

## Instructions

For ease setup an `.env` file was added to configure container environment variables. You can add or remove other environment variables as needed.

To start up the development environment:
```bash
./start.sh
```
or
```bash
sudo docker-compose run --service-ports dev bash
```

In container prompt you can test if PostgreSQL is running with credentials user: `postgres` and password: `postgres`.
```bash
psql -h db -U "postgres"
```

All content of `src` folder are mount to `/home/src` of container.

You can access your Node.js and Ionic application through the `8000` and `8100` ports respectively.