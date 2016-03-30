echo "Checking Image centos:centos6"
echo "THIS FRESH CENTOS6 CONTAINER WILL BE  AUTOMATICALLY DESTROYED AFTER EXIT"

docker run -it --rm -v `pwd`:/build --name rpm_checker --dns=8.8.8.8 centos:centos6 /bin/bash
