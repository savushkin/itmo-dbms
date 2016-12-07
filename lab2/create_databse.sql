CREATE DATABASE fakerole
        USER SYS IDENTIFIED BY 1552
        USER SYSTEM IDENTIFIED BY system1552
        LOGFILE GROUP 1 ('/u01/logs/oracle/fakeroledb/redo01.log') SIZE 100M REUSE,
                GROUP 2 ('/u01/logs/oracle/fakeroledb/redo02.log') SIZE 100M REUSE,
                GROUP 3 ('/u01/logs/oracle/fakeroledb/redo03.log') SIZE 100M REUSE
        MAXLOGFILES 5
        MAXLOGMEMBERS 5
        MAXLOGHISTORY 1
        MAXDATAFILES 100
        CHARACTER SET AL32UTF8
        NATIONAL CHARACTER SET AL16UTF16
        EXTENT MANAGEMENT LOCAL
        DATAFILE '/u01/app/oracle/oradata/node03/etexa3.dbf'
                 SIZE 325M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
                 '/u01/app/oracle/oradata/node03/enasi19.dbf'
                 SIZE 325M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
                 '/u01/app/oracle/oradata/node03/ubita63.db'
                 SIZE 325M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        SYSAUX DATAFILE '/u01/app/oracle/oradata/node02/pom27.dbf'
                 SIZE 325M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED,
                 '/u01/app/oracle/oradata/node01/toq96.dbf'
                 SIZE 325M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        DEFAULT TABLESPACE USERS
                 DATAFILE '/u01/app/oracle/oradata/node04/ugofeko309.dbf'
                 SIZE 250M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        DEFAULT TEMPORARY TABLESPACE tempts1
                 TEMPFILE '/u01/app/oracle/oradata/node01/temp01.dbf'
                 SIZE 20M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
        UNDO TABLESPACE undotbs1
                 DATAFILE '/u01/app/oracle/oradata/node01/undotbs01.dbf'
                 SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;