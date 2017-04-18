su -
cd /etc/yum.repos.d && wget http://yum.oracle.com/public-yum-el4.repo
yum list
yum update
yum install net-tools -y

cat >> /etc/hosts <<EOF
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

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE=eth0
BOOTPROTO=none
HWADDR=08:00:27:6E:F1:7F
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
IPV6INIT=no
PEERDNS=yes
NETMASK=255.255.255.0
IPADDR=192.168.2.101
GATEWAY=192.168.2.101
EOF
cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
DEVICE=eth1
BOOTPROTO=none
BROADCAST=10.1.4.255
HWADDR=08:00:27:3A:7A:AF
IPADDR=10.1.4.246
NETMASK=255.255.255.0
NETWORK=10.1.4.0
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
IPV6INIT=no
PEERDNS=yes
EOF

cat > /etc/sysconfig/network <<EOF
NETWORKING=yes
NETWORKING_IPV6=no
HOSTNAME=annoyedprobe0.oracle.com
EOF

service network restart

yum install oracle-validated -y
yum update -y

#cat > /etc/sysctl.conf <<EOF
#fs.aio-max-nr = 1048576
#fs.file-max = 6815744
#kernel.shmall = 2097152
#kernel.shmmax = 1054504960
#kernel.shmmni = 4096
## semaphores: semmsl, semmns, semopm, semmni
#kernel.sem = 250 32000 100 128
#net.ipv4.ip_local_port_range = 9000 65500
#net.core.rmem_default=262144
#net.core.rmem_max=4194304
#net.core.wmem_default=262144
#net.core.wmem_max=1048586
#EOF
#
#sysctl -p

#cat > /etc/security/limits.conf <<EOF
#oracle               soft    nproc   2047
#oracle               hard    nproc   16384
#oracle               soft    nofile  1024
#oracle               hard    nofile  65536
#EOF

cat >> /etc/pam.d/login <<EOF
session    required     pam_limits.so
EOF

groupadd -g 1000 oinstall
groupadd -g 1200 dba
useradd -u 500 -g oinstall -G oracle,dba oracle || usermod -u 500 -g oinstall -G oracle,dba oracle

mkdir -p /u01/app/11.2.0/grid
mkdir -p /u01/app/oracle/product/11.2.0/db_1
chown -R oracle:oinstall /u01
chmod -R 775 /u01/

# /etc/selinux/config
# SELINUX=permissive

# service iptables stop
# chkconfig iptables off

# service ntpd stop
# chkconfig ntpd off
# mv /etc/ntp.conf /etc/ntp.conf.orig
# rm /var/run/ntpd.pid

cd ~oracle/database/rpm/ && rpm -Uvh cvuqdisk-1.0.9-1.rpm

cat > ~oracle/.bashrc <<EOF
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
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
EOF

cat > ~oracle/grid_env <<EOF
ORACLE_SID=+ASM1; export ORACLE_SID
ORACLE_HOME=$GRID_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH
EOF

cat > ~oracle/db_env <<EOF
ORACLE_SID=RAC1; export ORACLE_SID
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
PATH=$ORACLE_HOME/bin:$BASE_PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH
EOF
