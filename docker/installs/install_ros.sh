function install_ros1 {
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    sudo apt-get update

    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ros-${ROS_DISTRO}-${ROS_INSTALL_TYPE}
    sudo apt-get install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

    sudo apt-get install -y python3-pip

    sudo rosdep init
    rosdep update
    source /opt/ros/${ROS_DISTRO}/setup.bash

    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ${HOME}/.bashrc
    source ${HOME}/.bashrc

    echo "\033[33mInstalled ROS ${ROS_DISTRO} \033[0m"
}

function install_ros2 {
    sudo apt-get update
    sudo apt-get install -y locales git gnupg2

    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    # setup keys
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

    # setup sources.list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    
    # install ros2 packages
    sudo apt-get update

    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ros-${ROS_DISTRO}-${ROS_INSTALL_TYPE} 

    sudo apt-get install -y python3-colcon-common-extensions python3-vcstool python3-pip python3-rosdep

    sudo rosdep init
    rosdep update

    source /opt/ros/${ROS_DISTRO}/setup.bash

    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ${HOME}/.bashrc
    source ${HOME}/.bashrc

    echo "\033[33mInstalled ROS ${ROS_DISTRO} \033[0m"
}

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y sudo curl lsb-release tzdata

if [ -z ${ROS_DISTRO} ];
then
  echo "ROS_DISTRO is missing!"
  exit 1
fi

if [ ${ROS_VERSION} == 1 ];
then
    install_ros1
else
    install_ros2
fi