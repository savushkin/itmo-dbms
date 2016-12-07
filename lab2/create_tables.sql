CREATE TABLESPACE DRY_ORANGE_ROAD LOGGING
        DATAFILE '/u01/app/oracle/oradata/node02/dryorangeroad01.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node03/dryorangeroad02.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE WET_GOLD_IDEA LOGGING
        DATAFILE '/u01/app/oracle/oradata/node02/wetgoldidea01.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node01/wetgoldidea02.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node02/wetgoldidea03.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node02/wetgoldidea04.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node02/wetgoldidea05.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE TALL_YELLOW_CITY LOGGING
        DATAFILE '/u01/app/oracle/oradata/node02/tallyellowcity01.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node02/tallyellowcity02.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
        '/u01/app/oracle/oradata/node03/tallyellowcity03.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE UGLY_GREEN_FOOD LOGGING
        DATAFILE '/u01/app/oracle/oradata/node04/uglygreenfood01.dbf'
        SIZE 100M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        EXTENT MANAGEMENT LOCAL;