VBoxManage createhd --filename asm1.vdi --size 5120 --format VDI --variant Fixed
VBoxManage createhd --filename asm2.vdi --size 5120 --format VDI --variant Fixed
VBoxManage createhd --filename asm3.vdi --size 5120 --format VDI --variant Fixed
VBoxManage createhd --filename asm4.vdi --size 5120 --format VDI --variant Fixed

VBoxManage storageattach annoyedprobe0 --storagectl "SATA" --port 1 --device 0 --type hdd \
    --medium asm1.vdi --mtype shareable
VBoxManage storageattach annoyedprobe0 --storagectl "SATA" --port 2 --device 0 --type hdd \
    --medium asm2.vdi --mtype shareable
VBoxManage storageattach annoyedprobe0 --storagectl "SATA" --port 3 --device 0 --type hdd \
    --medium asm3.vdi --mtype shareable
VBoxManage storageattach annoyedprobe0 --storagectl "SATA" --port 4 --device 0 --type hdd \
    --medium asm4.vdi --mtype shareable

VBoxManage modifyhd asm1.vdi --type shareable
VBoxManage modifyhd asm2.vdi --type shareable
VBoxManage modifyhd asm3.vdi --type shareable
VBoxManage modifyhd asm4.vdi --type shareable

cat >> /etc/hosts EOF
# Public
192.168.2.101 annoyedprobe0.oracle.com annoyedprobe0
192.168.2.102 annoyedprobe1.oracle.com annoyedprobe1
# Private
10.1.4.246 annoyedprobe0-priv.oracle.com annoyedprobe0-priv
10.1.4.247 annoyedprobe1-priv.oracle.com annoyedprobe1-priv
# Virtual
192.168.2.111 annoyedprobe0-vip.oracle.com annoyedprobe0-vip
192.168.2.112 annoyedprobe1-vip.oracle.com annoyedprobe1-vip
# SCAN
192.168.2.201 confide-scan.oracle.com confide-scan
192.168.2.202 confide-scan.oracle.com confide-scan
192.168.2.203 confide-scan.oracle.com confide-scan
EOF

neat annoyedprobe0 settings
eth0
    address: 192.168.2.101
    subnet mask: 255.255.255.0
    default gateway address: 192.168.2.1
    bind to MAC address: 08:00:27:58:dc:0e
eth1
    address: 10.1.4.246
    subnet mask: 255.255.255.0
    bind ti MAC adress: 08:00:27:35:20:b1
dns
    hostname: annoyedprobe0.oracle.com
    primary dns: 192.168.1.1
    dns search path: oracle.com

neat annoyedprobe1 settings
eth0
    address: 192.168.2.102
    subnet mask: 255.255.255.0
    default gateway address: 192.168.2.1
    bind to MAC address: 08:00:27:f9:da:a2
eth1
    address: 10.1.4.247
    subnet mask: 255.255.255.0
    bind ti MAC adress: 08:00:27:15:e9:20
dns
    hostname: annoyedprobe1.oracle.com
    primary dns: 192.168.1.1
    dns search path: oracle.com

#annoyedprobe0 .bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

ORACLE_HOSTNAME=annoyedprobe0.oracle.com; export ORACLE_HOSTNAME
ORACLE_UNQNAME=RAC; export ORACLE_UNQNAME
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
GRID_HOME=/u01/app/11.2.0/grid; export GRID_HOME
DB_HOME=$ORACLE_BASE/product/11.2.0/db_1; export DB_HOME
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
ORACLE_SID=RAC1; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
BASE_PATH=/usr/sbin:$PATH; export BASE_PATH
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

if [ $USER = "oracle" ]; then
    if [ $SHELL = "/bin/ksh" ]; then
        ulimit -p 16384
        ulimit -n 65536
    else
        ulimit -u 16384 -n 65536
    fi
fi

alias grid_env='. /home/oracle/grid_env'
alias db_env='. /home/oracle/db_env'

# User specific environment and startup programs
PATH=$PATH:$HOME/bin; export PATH

#annoyedprobe0 grid_env
ORACLE_SID=+ASM1; export ORACLE_SID
ORACLE_HOME=$GRID_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

#annoyedprobe0 db_env
ORACLE_SID=RAC1; export ORACLE_SID
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

#annoyedprobe1 .bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

ORACLE_HOSTNAME=annoyedprobe1.oracle.com; export ORACLE_HOSTNAME
ORACLE_UNQNAME=RAC; export ORACLE_UNQNAME
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
GRID_HOME=/u01/app/11.2.0/grid; export GRID_HOME
DB_HOME=$ORACLE_BASE/product/11.2.0/db_1; export DB_HOME
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
ORACLE_SID=RAC2; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
BASE_PATH=/usr/sbin:$PATH; export BASE_PATH
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

if [ $USER = "oracle" ]; then
if [ $SHELL = "/bin/ksh" ]; then
ulimit -p 16384
ulimit -n 65536
else
ulimit -u 16384 -n 65536
fi
fi

alias grid_env='. /home/oracle/grid_env'
alias db_env='. /home/oracle/db_env'

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

#annoyedprobe1 grid_env
ORACLE_SID=+ASM2; export ORACLE_SID
ORACLE_HOME=$GRID_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

#annoyedprobe1 db_env
ORACLE_SID=RAC2; export ORACLE_SID
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH