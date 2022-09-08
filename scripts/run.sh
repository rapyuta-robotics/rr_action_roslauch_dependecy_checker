#!/bin/bash
source $ROOT_PATH

out_file="$(cat /proc/sys/kernel/random/uuid).log"
BUILD_CONTAINER_NAME=$(docker create --workdir $SCRIPTS_PATH --entrypoint "$SCRIPTS_PATH/check.sh" $IMAGE_NAME $ENV_SETUP_PATH $CHECKING_PATH "$CHECKING_EXCLUDES")
docker cp scripts/check.sh $BUILD_CONTAINER_NAME:$SCRIPTS_PATH/check.sh
docker cp scripts/log.sh $BUILD_CONTAINER_NAME:$SCRIPTS_PATH/log.sh
docker start -a $BUILD_CONTAINER_NAME 2> $out_file
docker rm $BUILD_CONTAINER_NAME 1> /dev/null
if [ -s $out_file ]
then
    fatal "Missing dependencies in launch files"
    cat $out_file | grep -v 'wrote test'
else
    success "All checked files have their dependencies resolved"
fi
rm $out_file