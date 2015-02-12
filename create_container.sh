  1 echo "creating container"
  2 vzctl create $1 --ostemplate centos-6-x86_64 --ipadd $2 --hostname $3
  3 echo "setting nameserver"
  4 vzctl set $1 --nameserver 10.4.12.157 --save
  5 echo "starting container"
  6 vzctl start $1
  7 echo "setting proxy in container"
  8 cp ~/.bash_profile /vz/private/$1/root/
  9 cp /etc/yum.conf /vz/private/$1/etc/
 10 cat /vz/private/$1/root/.bash_profile
 11 vzctl exec $1 source ~/.bash_profile
 12 vzctl exec $1 echo $http_proxy
 13 vzctl exec $1 yum -y update
 14 vzctl exec $1 yum install -y httpd
 15 exit 0
