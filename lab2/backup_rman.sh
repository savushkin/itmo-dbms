#!/bin/bash
rman @$ORACLE_HOME/dbs/backup_rman && exit 0
exit 1
