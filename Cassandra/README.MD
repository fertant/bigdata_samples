Starting Cassandra server
`helm install cassandra bitnami/cassandra`

Starting cqlsh
`kubectl port-forward --namespace default svc/cassandra 9042:9042 & ~/BigData/cqlsh-astra/bin/cqlsh -u cassandra -p $CASSANDRA_PASSWORD 127.0.0.1 9042`
