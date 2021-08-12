
Start Kafka cluster with external access:
`helm install kafka -f values.yaml bitnami/kafka`

List all Kafka topics:
`kafka-topics.sh --list --bootstrap-server localhost:9094`
Create new Kafka topic:
`kafka-topics.sh --create --topic hotels --bootstrap-server localhost:9094`
Read topic from Kafka:
`kafka-console-consumer.sh --topic hotels --from-beginning --bootstrap-server localhost:9094`

Command for job submission:
`spark/bin/spark-submit --class ua.bigdata.spark.HotelsBookings --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 --master spark://<hostname>:7077 <path_to_project>/bigdata_samples/Spark/app/target/scala-2.12/hotels_assembly_2.12-1.0.jar`

`spark/bin/spark-submit --class ua.bigdata.spark.HotelsStayCountElastic --packages org.elasticsearch:elasticsearch-spark-20_2.12:7.14.0 --master spark://<hostname>:7077 <path_to_project>/bigdata_samples/Spark/app/target/scala-2.12/hotels_assembly_2.12-1.0.jar`



helm install elastic bitnami/elasticsearch --set global.kibanaEnabled=true

kubectl port-forward --namespace default svc/elastic-coordinating-only 9200:9200
kubectl port-forward --namespace default svc/elastic-kibana 8080:5601