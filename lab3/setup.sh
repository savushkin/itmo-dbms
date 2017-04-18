# Этап 1. Сконфигурировать экземпляр Oracle ASM на выделенном сервере и настроить его на работу с базой данных, созданной при выполнении лабораторной работы №1:
#
#    Необходимо использовать тот же узел, что и в лабораторной работе №2.
#    Имя сервиса: ASM.100000, где 100000 - ID студента.
#    ASM_POWER_LIMIT: 6.
#    Количество дисковых групп: 2.
#    Имена и размерности дисковых групп: "famoushamster[3]", "carelessdog[5]".
#    В качестве хранилища данных (дисков) необходимо использовать файлы. Имена файлов должны строиться по шаблону $DISKGROUP_NAME$X, где $DISKGROUP_NAME - имя дисковой группы, а $X - порядковый номер файла в группе (нумерация начинается с нуля).
#    Путь к файлам ASM - "/u01/$DISKGROUP_NAME/$DISK_FILE_NAME".
#    Существующие файлы БД необходимо смигрировать в хранилище ASM.

# /u01/app/11.2.0/grid/dbs/init+ASM.ora

export ORACLE_SID=+ASM
export ORACLE_HOME=/u01/app/11.2.0/grid
export PATH=$PATH:$ORACLE_HOME/bin

cd /u01/app/11.2.0/grid/bin && ./crsctl start resource ora.cssd

srvctl add asm
srvctl config asm
srvctl start asm
srvctl status asm

sqlplus "/ as sysasm" <<EOF
create spfile from pfile='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/init+ASM.ora';
shutdown
startup
EOF

mkdir /u01/famoushamster
dd if=/dev/zero of=/u01/famoushamster/famoushamster0 bs=1k count=100000
dd if=/dev/zero of=/u01/famoushamster/famoushamster1 bs=1k count=100000
dd if=/dev/zero of=/u01/famoushamster/famoushamster2 bs=1k count=100000
mkdir /u01/carelessdog
dd if=/dev/zero of=/u01/carelessdog/carelessdog0 bs=1k count=100000
dd if=/dev/zero of=/u01/carelessdog/carelessdog1 bs=1k count=100000
dd if=/dev/zero of=/u01/carelessdog/carelessdog2 bs=1k count=100000
dd if=/dev/zero of=/u01/carelessdog/carelessdog3 bs=1k count=100000
dd if=/dev/zero of=/u01/carelessdog/carelessdog4 bs=1k count=100000
mkdir /u01/youngpuppy
dd if=/dev/zero of=/u01/youngpuppy/youngpuppy0 bs=1k count=100000
dd if=/dev/zero of=/u01/youngpuppy/youngpuppy1 bs=1k count=100000
dd if=/dev/zero of=/u01/youngpuppy/youngpuppy2 bs=1k count=100000
dd if=/dev/zero of=/u01/youngpuppy/youngpuppy3 bs=1k count=100000
mkdir /u01/unluckypig
dd if=/dev/zero of=/u01/unluckypig/unluckypig0 bs=1k count=100000
dd if=/dev/zero of=/u01/unluckypig/unluckypig1 bs=1k count=100000
dd if=/dev/zero of=/u01/unluckypig/unluckypig2 bs=1k count=100000
dd if=/dev/zero of=/u01/unluckypig/unluckypig3 bs=1k count=100000
dd if=/dev/zero of=/u01/unluckypig/unluckypig4 bs=1k count=100000

sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP famoushamster NORMAL REDUNDANCY
DISK '/u01/famoushamster/famoushamster0',
'/u01/famoushamster/famoushamster1',
'/u01/famoushamster/famoushamster2'
ATTRIBUTE 'au_size'='4M';

CREATE DISKGROUP carelessdog NORMAL REDUNDANCY
DISK '/u01/carelessdog/carelessdog0',
'/u01/carelessdog/carelessdog1',
'/u01/carelessdog/carelessdog2',
'/u01/carelessdog/carelessdog3',
'/u01/carelessdog/carelessdog4'
ATTRIBUTE 'au_size'='4M';
EOF

export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=S182190
export NLS_LANG=AMERICAN_RUSSIA.AL32UTF8
export ORADATA=$ORACLE_BASE/oradata
export PATH=$PATH:$ORACLE_HOME/bin

cd $ORACLE_HOME/bin
rman target / << EOF
STARTUP FORCE MOUNT;
SQL 'ALTER DATABASE ARCHIVELOG';
BACKUP AS COPY INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG
SWITCH DATABASE TO COPY;
RECOVER DATABASE;
ALTER DATABASE OPEN;
EOF

# Этап 2. Внести в конфигурацию ASM ряд изменений в приведённой ниже последовательности:

#    Пересоздать группу "famoushamster", сконфигурировав в ней избыточность следующим образом:
#        Размер группы - 8 элементов.
#        Тип избыточности - "NORMAL"; количество failure-групп - 4.
#        Равномерно распределить диски по failure-группам.
sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP famoushamster NORMAL REDUNDANCY
FAILGROUP F0 DISK
'/u01/famoushamster/famoushamster0',
'/u01/famoushamster/famoushamster1'
FAILGROUP F1 DISK
'/u01/famoushamster/famoushamster2',
'/u01/famoushamster/famoushamster3'
FAILGROUP F2 DISK
'/u01/famoushamster/famoushamster4',
'/u01/famoushamster/famoushamster5'
FAILGROUP F3 DISK
'/u01/famoushamster/famoushamster6',
'/u01/famoushamster/famoushamster7'
ATTRIBUTE 'au_size'='4M';
EOF

#    Пересоздать группу "famoushamster", сконфигурировав в ней избыточность следующим образом:
#        Размер группы - 9 элементов.
#        Тип избыточности - "HIGH"; количество failure-групп - 3.
#        Равномерно распределить диски по failure-группам.
sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP famoushamster HIGH REDUNDANCY
FAILGROUP F0 DISK
'/u01/famoushamster/famoushamster0',
'/u01/famoushamster/famoushamster1',
'/u01/famoushamster/famoushamster2'
FAILGROUP F1 DISK
'/u01/famoushamster/famoushamster3',
'/u01/famoushamster/famoushamster4',
'/u01/famoushamster/famoushamster5'
FAILGROUP F2 DISK
'/u01/famoushamster/famoushamster6',
'/u01/famoushamster/famoushamster7',
'/u01/famoushamster/famoushamster8'
ATTRIBUTE 'au_size'='4M';
EOF

#    Добавить новую дисковую группу "youngpuppy[3]"; размер AU - 16 МБ.
sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP youngpuppy NORMAL REDUNDANCY
DISK '/u01/youngpuppy/youngpuppy0',
'/u01/youngpuppy/youngpuppy1',
'/u01/youngpuppy/youngpuppy2'
ATTRIBUTE 'au_size'='16M';
EOF

#    Удалить дисковую группу "famoushamster".
sqlplus "/ as sysasm" <<EOF
DROP DISKGROUP famoushamster;
EOF

#    Пересоздать группу "youngpuppy", сконфигурировав в ней избыточность следующим образом:
#        Размер группы - 6 элементов.
#        Тип избыточности - "HIGH"; количество failure-групп - 2.
#        Равномерно распределить диски по failure-группам.
sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP youngpuppy HIGH REDUNDANCY
FAILGROUP F0 DISK
'/u01/famoushamster/famoushamster0',
'/u01/famoushamster/famoushamster1',
'/u01/famoushamster/famoushamster2'
FAILGROUP F1 DISK
'/u01/famoushamster/famoushamster3',
'/u01/famoushamster/famoushamster4',
'/u01/famoushamster/famoushamster5'
ATTRIBUTE 'au_size'='4M';
EOF

#    Удалить диск #4 из группы "youngpuppy".
sqlplus "/ as sysasm" <<EOF
ALTER DISKGROUP youngpuppy DROP DISK youngpuppy4;
EOF

#    Добавить новую дисковую группу "unluckypig[5]"; размер AU - 16 МБ.
sqlplus "/ as sysasm" <<EOF
CREATE DISKGROUP unluckypig NORMAL REDUNDANCY
DISK '/u01/unluckypig/unluckypig0',
'/u01/unluckypig/unluckypig1',
'/u01/unluckypig/unluckypig2',
'/u01/unluckypig/unluckypig3',
'/u01/unluckypig/unluckypig4',
ATTRIBUTE 'au_size'='16M';
EOF

#    Удалить диск #4 из группы "youngpuppy".
sqlplus "/ as sysasm" <<EOF
ALTER DISKGROUP youngpuppy DROP DISK youngpuppy4;
EOF

#    Удалить диск #3 из группы "unluckypig".
sqlplus "/ as sysasm" <<EOF
ALTER DISKGROUP unluckypig DROP DISK unluckypig3;
EOF