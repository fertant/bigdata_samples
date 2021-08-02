Main source projects for Hadoop, Streamset and Kafka clusters:

https://github.com/big-data-europe/docker-hadoop
https://hub.docker.com/r/bitnami/kafka/

Start application set with command
`docker-compose up -d`

Review docker container names inside docker network
`docker-compose ps`

StreamSet packed without Hadoop and Groovy libraries.
Restart container with StreamSet after library installation:
`docker ps | grep sdc | awk '{print $1}' | xargs docker restart`

Pipeline configuration included in this project and all screens with implementation uploaded in images folder. Before you will start upload data into hadoop container:
`docker cp <local_path> <container_id>:/tmp`
and put data into HDFS
`docker exec -it <container_id> -- hdfs dfs -mkdir /hotels`
`docker exec -it <container_id> -- hdfs dfs -put /tmp/*.csv /hotels/`
