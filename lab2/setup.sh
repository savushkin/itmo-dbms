SHELL=/bin/bash
exec $SHELL
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi


export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=S182190
export NLS_LANG=AMERICAN_RUSSIA.AL32UTF8
export ORADATA=$ORACLE_BASE/oradata
export PATH=$PATH:$ORACLE_HOME/bin

# password file
orapwd file=$ORACLE_BASE/passwdS182190

# cron
7 * * * * $ORACLE_HOME/dbs/backup_rman.sh &>/dev/null