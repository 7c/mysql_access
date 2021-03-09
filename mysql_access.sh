#!/bin/bash
##  Reads all databases
##  Filters some of the databases
##  Lists all their tables and last UPDATE_TIME of them

##  https://dev.mysql.com/doc/refman/5.7/en/information-schema-tables-table.html
##
##  When the data file was last updated. For some storage engines, this value is NULL. For example, InnoDB stores multiple tables in its system tablespace and the data file timestamp does not apply. Even with file-per-table mode with each InnoDB table in a separate .ibd file, change buffering can delay the write to the data file, so the file modification time is different from the time of the last insert, update, or delete. For MyISAM, the data file timestamp is used; however, on Windows the timestamp is not updated by updates, so the value is inaccurate.
##  UPDATE_TIME displays a timestamp value for the last UPDATE, INSERT, or DELETE performed on InnoDB tables that are not partitioned. For MVCC, the timestamp value reflects the COMMIT time, which is considered the last update time. Timestamps are not persisted when the server is restarted or when the table is evicted from the InnoDB data dictionary cache.
##  The UPDATE_TIME column also shows this information for partitioned InnoDB tables.

## Usage
##
## ./mysql_access.sh  [mysql command line options like -p<pass>]

arg1="$1 $2 $3 $4 $5 $6 $7"
## read all databases into an array
dbs=()
for i in $(mysql $arg1 -e 'show databases'); do
    ## skip some important folders
    if [ "$i" == "mysql" ] || [ "$i" == "Database" ] || [ "$i" == "information_schema" ];  then
        continue
    fi
    dbs+=($i);
done

for db in "${dbs[@]}"; do 
    echo "DATABASE: $db";
    mysql "$arg1" -e "SELECT TABLE_NAME, UPDATE_TIME,ENGINE FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '$db' ORDER BY UPDATE_TIME"
done