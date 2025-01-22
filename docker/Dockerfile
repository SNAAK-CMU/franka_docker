ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG ROS_DISTRO
ARG ROS_VERSION
ARG INSTALL_ROS
ARG PRE_INSTALL
ARG POST_INSTALL
ARG EXTRA_CMD

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

ENV ROS_DISTRO ${ROS_DISTRO}
ENV ROS_VERSION ${ROS_VERSION}
ENV ROS_INSTALL_TYPE desktop
ENV ROS_WS ${HOME}/ros/${ROS_DISTRO}

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

SHELL ["/bin/bash", "-c"]

RUN mkdir -p ${ROS_WS}/src

RUN eval ${PRE_INSTALL}

COPY ./docker/installs /home/installs
RUN chmod +x /home/installs/*
RUN if [ ${INSTALL_ROS} == True ]; then \
    /bin/bash /home/installs/install_ros.sh; fi

# run any custom command
RUN eval ${POST_INSTALL}
RUN eval ${EXTRA_CMD}

WORKDIR ${ROS_WS}

COPY ./docker/ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
