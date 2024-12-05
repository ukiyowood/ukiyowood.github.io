```sql
show variables like '%slow%';
```
## mysql / rds 开启慢日志查询
```sql
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2.0;
SET GLOBAL log_output = 'TABLE';
```