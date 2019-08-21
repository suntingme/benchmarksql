支持ddb所做修改：
--------------------------------------
   - 增加/run/sql.mysql
   其中tableCreates.sql更改为ddb建表语句；去掉主键（会导致主键冲突）
   - DDL执行增加1s等待，以解决分布式建表慢的问题
   - 去掉子查询，DDB不支持
   - Join语句语法修改，DDB支持不完整
   - /run/funcs.sh 语句修改，case语句支持不准确


   测试执行过程：
   --------------------------------------
   - 建表：./runSQL.sh props.mysql sql.mysql/tableCreates.sql
   - 建索引：./runSQL.sh props.mysql sql.mysql/indexCreates.sql
   - load数据：./runLoader.sh props.ddb
   - 执行：nohup ./runBenchmark.sh props.ddb &> test.log &
   - 删表：./runSQL.sh props.mysql sql.mysql/tableDrops.sql
   - 备注：DDL执行（建表/建索引/删表)需要使用props.mysql，DML执行使用props.ddb
