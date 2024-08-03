# Delta Lake tute

```
conda create -n deltalake-tute python=3.12
conda activate deltalake-tute

pip install -r requirements.txt

which pyspark

pyspark --help

pyspark \
    --packages io.delta:delta-spark_2.12:3.2.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
```


## PySpark Shell

```
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 3.5.1
      /_/

Using Python version 3.12.4 (main, Jun 18 2024 10:07:17)
Spark context Web UI available at http://localhost:4040
Spark context available as 'sc' (master = local[*], app id = local-1722669259694).
SparkSession available as 'spark'.
>>>
>>> help()
help> quit
>>>
```

- Observe http://localhost:4040


## Delta Table

_... while at PySpark Shell, continue to create "Delta Table" like so:_

```
>>> data = spark.range(0, 5)

>>> data
DataFrame[id: bigint]

>>> type(data)
<class 'pyspark.sql.dataframe.DataFrame'>

>>> data.write.format("delta").save("./out/delta-table")

>>> df = spark.read.format("delta").load("./out/delta-table")

>>> df
DataFrame[id: bigint]

>>> df.printSchema()
root
 |-- id: long (nullable = true)

>>> df.show()
+---+
| id|
+---+
|  3|
|  4|
|  1|
|  0|
|  2|
+---+

>>> data = spark.range(5, 10)

>>> data.write.format("delta").mode("overwrite").save("./out/delta-table")

>>> df = spark.read.format("delta").load("./out/delta-table")

>>> df.show()
+---+
| id|
+---+
|  8|
|  9|
|  6|
|  5|
|  7|
+---+

>>> exit()
```

```
$ tree out/delta-table

out/delta-table
├── _delta_log
│   ├── 00000000000000000000.json
│   ├── 00000000000000000001.json
│   └── _commits
├── part-00000-373afa6b-9ee8-43a3-b8ab-6f449c205cad-c000.snappy.parquet
├── part-00000-c1f934e0-9854-477a-9faa-5d1e11a53b74-c000.snappy.parquet
├── part-00002-2968b69f-892e-4d92-b161-3c4e61b95584-c000.snappy.parquet
├── part-00002-2ebb6904-b9aa-46e7-89af-05902f34f9d4-c000.snappy.parquet
├── part-00004-adabea16-b5cb-4e7c-9109-bdcc1604ae5b-c000.snappy.parquet
├── part-00004-e635bc4d-d239-453d-bfa0-c5b771136243-c000.snappy.parquet
├── part-00007-d0201839-59b4-4ec0-bff4-73e18cec97e5-c000.snappy.parquet
├── part-00007-d48851b0-8821-4c7f-ac79-9b6632213c04-c000.snappy.parquet
├── part-00009-5adb3fee-6a4b-401f-adfe-5fbb0b99ab16-c000.snappy.parquet
├── part-00009-b271b72a-673e-453b-a453-7f50ea4984fc-c000.snappy.parquet
├── part-00011-42910d45-e150-41a5-8eca-b4337afdb8f6-c000.snappy.parquet
└── part-00011-a23f82fc-0d84-4557-bf8a-b9fb9076191a-c000.snappy.parquet

3 directories, 14 files
```

Reading:
- [Delta Lake: High-Performance ACID Table Storage over Cloud Object Stores](https://www.databricks.com/wp-content/uploads/2020/08/p975-armbrust.pdf)
- https://github.com/delta-io/delta/blob/v3.2.0/PROTOCOL.md

> Does Delta Lake support multi-table transactions?
> 
> Delta Lake does not support multi-table transactions and foreign keys. Delta Lake supports transactions at the table level. 
> REF;[FAQ](https://docs.delta.io/latest/delta-faq.html#does-delta-lake-support-multi-table-transactions)


## Quickstart Notebook

```
$ jupyter-lab
(CTRL + C)
```

- Go to http://localhost:8888/lab
- Open [quickstart.ipynb](quickstart.ipynb) in JupyterLab
- Execute each Notebook cells (_Shift + Enter_) -- one by one to observe

REF:
- https://docs.delta.io/latest/quick-start.html
- https://docs.delta.io/latest/api/python/index.html

## Notes

### Storage

```
$ tree out/checkpoint
$ tree out/delta-table
$ ls -lh out/delta-table/
```

> This quickstart uses local paths for Delta table locations. For configuring HDFS or cloud storage for Delta tables, see Storage configuration.

- https://docs.delta.io/latest/delta-storage.html

### Re-Spin

```
rm -rf out/delta-table
rm -rf out/checkpoint
```

### Related

- https://github.com/victorskl/iceberg-tute
- https://github.com/victorskl/hudi-tute
