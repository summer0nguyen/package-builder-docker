DOCKER_CONTAINER_NAME="rpm_builder"

DOCKER_CONTAINER_STATUS=$(docker inspect -f {{.State.Running}} $DOCKER_CONTAINER_NAME)

if [ $? -gt 0 ];
then
	docker run -it -v `pwd`:/build  --name rpm_builder summernguyen/rpm-builder /bin/bash
else
	if [ $DOCKER_CONTAINER_STATUS="false " ];
	then
		docker start $DOCKER_CONTAINER_NAME
	fi

	echo "Docker container $DOCKER_CONTAINER_NAME started. Press ENTER to continue"

	docker attach $DOCKER_CONTAINER_NAME

fi


