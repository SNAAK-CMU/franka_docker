#!/usr/bin/env bash

set -e

# setup ros environment
[[ -f /opt/ros/$ROS_DISTRO/setup.bash ]] && source "/opt/ros/$ROS_DISTRO/setup.bash"

if [[ ${ROS_VERSION} == 1 ]];
then
    [[ -f $ROS_WS/devel/setup.bash ]] && source "$ROS_WS/devel/setup.bash"
else
    [[ -f $ROS_WS/install/setup.bash ]] && source "$ROS_WS/install/setup.bash"
fi

exec "$@"