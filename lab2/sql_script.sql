connect sys as sysdba
create spfile from pfile;
startup nomount;
@create_databse.sql
@create_tables.sql
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/sqlplus/admin/pupbld.sql


CREATE TABLE People (
         id      NUMBER(5) PRIMARY KEY,
         first_name      VARCHAR2(15) NOT NULL,
         last_name      VARCHAR2(15) NOT NULL)
   TABLESPACE UGLY_GREEN_FOOD;

INSERT INTO People VALUES (0, 'firstName0', 'lastName0');
INSERT INTO People VALUES (1, 'firstName1', 'lastName1');
INSERT INTO People VALUES (2, 'firstName2', 'lastName2');
INSERT INTO People VALUES (3, 'firstName3', 'lastName3');