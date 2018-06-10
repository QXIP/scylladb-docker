# scylladb-docker
Docker container for scylladb + compose cluster

### Build Image
```
docker built -t qxip/scylladb .
````


### Compose
```
docker-compose up -d
```
##### nodetool status
```
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.2  360.14 KB  256          67.1%             262f5811-d264-4ce5-b023-644fbb8c8686  Rack1
UN  10.10.10.3  492.12 KB  256          69.2%             150712f9-1f43-491f-8e52-21854a894713  Rack1
UN  10.10.10.1  338.92 KB  256          63.7%             a9d6b757-5e5f-4012-891c-7de665087f1e  Rack1
```
