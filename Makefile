install:
	@pip install -r requirements.txt

pyspark:
	@pyspark \
    --packages io.delta:delta-spark_2.12:3.2.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"

start:
	@jupyter-lab

clean:
	@rm -rf out/delta-table
	@rm -rf out/checkpoint
