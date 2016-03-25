yum -y install  pcre pcre-devel  rsyslog zip unzip gcc gcc-c++ openssl openssl-devel zlib gd freetype freetype-devel autoconf openldap openldap-devel bzip2-devel libpng libpng-devel libjpeg libjpeg-devel perl-ExtUtils-Embed




#Compile Nginx with options

NGINX_RELEASE_VERSION="1.8.1"
OWNER_RELEASE_TIME="1"
VERSION="${NGINX_RELEASE_VERSION}.${OWNER_RELEASE_TIME}"
mkdir -p /tmp/builder/nginx/src
cp /build/BUILDS/NGINX/SRC/nginx-${NGINX_RELEASE_VERSION}.tar.gz /tmp/builder/nginx/src

cd /tmp/builder/nginx/src
tar -zxvf nginx-${NGINX_RELEASE_VERSION}.tar.gz

cd nginx-${NGINX_RELEASE_VERSION}

./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock  --without-http_browser_module --without-http_geo_module --without-http_empty_gif_module --without-http_map_module --without-http_memcached_module --without-http_ssi_module --without-http_userid_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --without-http_split_clients_module --without-http_uwsgi_module --without-http_scgi_module --with-http_ssl_module --with-http_perl_module --with-http_realip_module --with-pcre --with-http_gzip_static_module  --with-http_gunzip_module
make
make install


cd ..
rm -rfv /tmp/builder/nginx/src

cp /build/BUILDS/NGINX/SRC/nginx.init /etc/init.d/nginx
chmod +x /etc/init.d/nginx
#Compile DONE, you should check if Nginx is starting OK


#Prepare to Build RPM
mkdir -p /tmp/builder/nginx/build

cd /tmp/builder/nginx/build

mkdir -p etc/nginx usr/sbin var/log/nginx etc/init.d/ usr/local/lib64/perl5/auto/nginx/
rsync -avz /etc/nginx/. etc/nginx
rsync -avz /usr/sbin/nginx usr/sbin/nginx
rsync -avz /etc/init.d/nginx etc/init.d/nginx
rsync -avz /usr/local/lib64/perl5/auto/nginx/. usr/local/lib64/perl5/auto/nginx/
rsync -avz /usr/local/lib64/perl5/nginx.pm usr/local/lib64/perl5/nginx.pm



#Build RPM

fpm -s dir -t rpm -n nginx -v ${VERSION} -p nginx-VERSION.rpm --url "http://summernguyen.net" --description "Nginx ${VERSION}" --vendor "Summer Nguyen" -d pcre -d pcre-devel  -d zip -d unzip -d gcc -d gcc-c++ -d openssl -d openssl-devel -d zlib -d gd -d freetype -d freetype-devel -d autoconf -d openldap -d openldap-devel -d bzip2-devel -d libpng -d libpng-devel -d libjpeg -d libjpeg-devel -d perl-ExtUtils-Embed  usr etc var

cp nginx-${VERSION}.rpm /build/RPMS
#Delete Build Folder

rm -rf usr etc var 