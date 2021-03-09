## mysql_access script
this tiny script does check last modification time of mysql tables per database. This script has some limitations. Please read official disclaimer. I have been using this script to determine which databases are not modified anymore, this gives me the freedom to cleanup or question databases or even tables

## Official Documentation
From  https://dev.mysql.com/doc/refman/5.7/en/information-schema-tables-table.html

When the data file was last updated. For some storage engines, this value is NULL. For example, InnoDB stores multiple tables in its system tablespace and the data file timestamp does not apply. Even with file-per-table mode with each InnoDB table in a separate .ibd file, change buffering can delay the write to the data file, so the file modification time is different from the time of the last insert, update, or delete. For MyISAM, the data file timestamp is used; however, on Windows the timestamp is not updated by updates, so the value is inaccurate.

UPDATE_TIME displays a timestamp value for the last UPDATE, INSERT, or DELETE performed on InnoDB tables that are not partitioned. For MVCC, the timestamp value reflects the COMMIT time, which is considered the last update time. Timestamps are not persisted when the server is restarted or when the table is evicted from the InnoDB data dictionary cache.

The UPDATE_TIME column also shows this information for partitioned InnoDB tables.



## Usage
```
./mysql_access.sh
./mysql_access.sh -p674245
./mysql_access.sh -p67244
```

## Example output
```
DATABASE: xlam
+----------------+---------------------+--------+
| TABLE_NAME     | UPDATE_TIME         | ENGINE |
+----------------+---------------------+--------+
| dnp_admin      | 2016-07-28 12:42:35 | MyISAM |
| dnp_domains    | 2016-07-28 12:42:35 | MyISAM |
| dnp_dom2cat    | 2016-07-28 12:42:35 | MyISAM |
| dnp_config     | 2016-07-28 12:42:35 | MyISAM |
| dnp_categories | 2016-07-28 12:42:35 | MyISAM |
+----------------+---------------------+--------+
```

