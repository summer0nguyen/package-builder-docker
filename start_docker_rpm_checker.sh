echo "Checking Image centos:centos6"
docker pull centos:centos6

echo "THIS FRESH CENTOS6 CONTAINER WILL BE  AUTOMATICALLY DESTROYED AFTER EXIT"

docker run -it --rm -v `pwd`:/build --name rpm_checker  centos:centos6 /bin/bash