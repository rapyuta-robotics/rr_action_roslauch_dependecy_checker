#!/bin/bash
set -e
source $ROOT_PATH/scripts/log.sh

delete_container() {
    info "Deleting helper container"
    docker rm $1 1> /dev/null
}

out_file="$(cat /proc/sys/kernel/random/uuid).log"
container_name=$(docker create --workdir $SCRIPTS_PATH --entrypoint "$SCRIPTS_PATH/check.sh" $IMAGE_NAME $ENV_SETUP_PATH $CHECKING_PATH "$CHECKING_EXCLUDES")
docker cp $ROOT_PATH/scripts/check.sh $container_name:$SCRIPTS_PATH/check.sh || delete_container $container_name
docker cp $ROOT_PATH/scripts/log.sh $container_name:$SCRIPTS_PATH/log.sh || delete_container $container_name
docker start -a $container_name 2> $out_file
delete_container $container_name
exit_code=0
if [ -s $out_file ]
then
    fatal "Missing dependencies in launch files"
    cat $out_file | grep -v 'wrote test'
    exit_code=1
else
    success "All checked files have their dependencies resolved"
fi
rm $out_file
exit $exit_code
