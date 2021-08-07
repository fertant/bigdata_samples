
Start Kafka cluster with external access:
`helm install kafka -f values.yaml bitnami/kafka`

List all Kafka topics:
`kafka-topics.sh --list --bootstrap-server localhost:9094`
Create new Kafka topic:
`kafka-topics.sh --create --topic hotels --bootstrap-server localhost:9094`
Read topic from Kafka:
`kafka-console-consumer.sh --topic hotels --from-beginning --bootstrap-server localhost:9094`

Command for job submission:
`spark/bin/spark-submit --class ua.bigdata.spark.HotelsBookings --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.0 --master spark://Andriis-MacBook-Pro-3.local:7077 ~/Git/bigdata_samples/Spark/app/target/scala-2.12/hotels_assembly_2.12-1.0.jar`