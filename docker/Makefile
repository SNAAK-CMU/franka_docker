SHELL:=/bin/bash

TYPE := up
MODE :=

define up_with_xhost
	xhost +
	$(1)
	xhost -
endef

define docker_compose
	$(call up_with_xhost, docker compose -f $(1) $(TYPE) $(MODE))
endef

.PHONY: all

build-noetic:
	python3 build.py --config ./configs/noetic.yaml
build-humble:
	python3 build.py --config ./configs/humble.yaml
build-azure-kinect-noetic:
	python3 build.py --config ./configs/azure_kinect_noetic.yaml
build-azure-kinect-humble:
	python3 build.py --config ./configs/azure_kinect_humble.yaml
build-franka-interface-noetic:
	python3 build.py --config ./configs/franka_interface_noetic.yaml
build-franka-interface-humble:
	python3 build.py --config ./configs/franka_interface_humble.yaml
build-frankapy-noetic: build-noetic
	python3 build.py --config ./configs/frankapy_noetic.yaml
build-frankapy-humble: build-humble
	python3 build.py --config ./configs/frankapy_humble.yaml


run-azure-kinect-noetic:
	$(call docker_compose, ./compose/docker-compose.azure_kinect_noetic.yml)
run-azure-kinect-humble:
	$(call docker_compose, ./compose/docker-compose.azure_kinect_humble.yml)
run-franka-interface-noetic:
	$(call docker_compose, ./compose/docker-compose.franka_interface_noetic.yml)
run-franka-interface-humble:
	$(call docker_compose, ./compose/docker-compose.franka_interface_humble.yml)