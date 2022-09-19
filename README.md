# Delta Lake tute

```
conda create -n deltalake-tute python=3.10
conda activate deltalake-tute

pip install -r requirements.txt

which pyspark

pyspark --help

pyspark \
    --packages io.delta:delta-core_2.12:2.1.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
```


## PySpark Shell

```
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 3.3.0
      /_/

Using Python version 3.10.6 (main, Aug 22 2022 20:41:54)
Spark context Web UI available at http://localhost:4040
Spark context available as 'sc' (master = local[*], app id = local-1234567890000).
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
│   └── 00000000000000000001.json
├── part-00000-b6a5241d-bc57-4f98-b7d2-fae603c0e549-c000.snappy.parquet
├── part-00000-feaa2c42-bd44-47ae-af67-e4b4b9c678ec-c000.snappy.parquet
├── part-00001-3f6d78ef-5bbd-4e3b-bb4c-c25479d67b48-c000.snappy.parquet
├── part-00001-d993842e-8173-4311-8f4e-0f2c8132cf10-c000.snappy.parquet
├── part-00002-41594f24-a72a-4f8d-bf55-e59143213815-c000.snappy.parquet
├── part-00002-4f6bfeb1-1f6f-487e-8c4a-aa8cce658741-c000.snappy.parquet
├── part-00003-019d1f38-d73e-4935-b9a1-2d0840893e11-c000.snappy.parquet
└── part-00003-be56059f-09e7-4f44-807d-d71d8bc0486b-c000.snappy.parquet

1 directory, 10 files
```

Reading:
- [Delta Lake: High-Performance ACID Table Storage over Cloud Object Stores](https://www.databricks.com/wp-content/uploads/2020/08/p975-armbrust.pdf)
- https://github.com/delta-io/delta/blob/v2.1.0/PROTOCOL.md

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
