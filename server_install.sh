yum update
yum install httpd
yum install mysql-server
yum install php
yum install php-devel
yum install php-pear
yum install php-mysql
yum install php-mbstring
yum install php-mcrypt

#pear install DB
chkconfig --level 3 mysqld on
chkconfig --level 3 httpd on

if [ ! -d "/etc/httpd/sites-enabled" ]; then
	mkdir /etc/httpd/sites-enabled
	if [ ! -d "/var/sites" ]; then
		mkdir /var/sites
		git clone git://github.com/jameslarking/Server-Default-Holding-Site.git /var/sites/1-default
	fi	
fi
cp 1-default.conf /etc/httpd/sites-enabled/
cp httpd.amends.conf /etc/httpd/conf.d/
cp php.d/*.ini /etc/php.d/



cd /var/sites/1-default
git pull origin master

cd /var/www/
git clone  git://phpmyadmin.git.sourceforge.net/gitroot/phpmyadmin/phpmyadmin
cd /var/www/phpmyadmin/
git checkout origin/STABLE
git pull
chown -R ec2-user /var/www
chown -R ec2-user /var/sites

/etc/init.d/httpd restart
/etc/init.d/mysqld restart
