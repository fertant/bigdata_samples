"""Spark DAG with hotels stay type calculation."""

from datetime import timedelta
from textwrap import dedent

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators import SparkSubmitOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'andrii_shutov',
    'depends_on_past': False,
    'email': ['shutova@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}
with DAG(
    dag_id='Spark pipeline for hotels stay type calculation.',
    default_args=default_args,
    schedule_interval='0 0 * * *',
    start_date=days_ago(2),
    dagrun_timeout=timedelta(minutes=60),
    tags=['spark', 'hotels', 'expedia'],
    params={
        "spark_submit": "~/BigData/spark/bin/spark-submit",
        "spark_instance": "spark://localhost:7077",
        "job_jar": "~/BigData/bigdata_samples/Spark/app/target/scala-2.12/hotels_assembly_2.12-1.0.jar",
    },
) as dag:

    spark_command = dedent(
    """
        "{{ params.spark_submit }}" --class "{{ params.execution.class }}" --master "{{ params.spark_instance }}" "{{ params.job_jar }}"
    """
    )

    geohash = BashOperator(
        task_id='geohash',
        depends_on_past=False,
        bash_command=spark_command,
        params={"excution_class": "ua.bigdata.spark.HotelsCoordinates"},
    )

    stay_count = BashOperator(
        task_id='expedia',
        depends_on_past=False,
        bash_command=spark_command,
        params={"excution_class": "ua.bigdata.spark.HotelsStayCountHDFS"},
    )

    bookings = SparkSubmitOperator(
        task_id='bookings',
        application_file="~/BigData/bigdata_samples/Spark/app/target/scala-2.12/hotels_assembly_2.12-1.0.jar",
        main_class="ua.bigdata.spark.HotelsBooking",
        master="spark://localhost:7077",
        dag=dag)

    geohash >> [stay_count, bookings]
