#!/usr/bin/env python

import argparse
import os
import subprocess
import sys
import warnings

import yaml


def parse(config_path: str) -> dict:

    config_path = os.path.normpath(config_path)

    assert os.path.isfile(config_path)

    with open(config_path, 'r') as stream:
        config = yaml.safe_load(stream)

    assert config

    config['DOCKERFILE'] = config_path.replace(config_path.split(os.sep)[-1], config['DOCKERFILE'])

    return config


def get_command_from_cfg(config: dict) -> str:
    tag = config['TAG']
    dockerfile = config['DOCKERFILE']

    try:
        context = config['CONTEXT']
    except KeyError:
        context = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../')
    assert os.path.isfile(dockerfile)
    try:
        args_str = []
        for arg, val in config['ARGS'].items():
            if arg == 'EXTRA_CMD':
                warnings.warn('EXTRA_CMD is deprecated and will be removed, Use POST_INSTALL')
            if arg in ['EXTRA_CMD', 'PRE_INSTALL', 'POST_INSTALL']:
                val = ' && '.join(val)
            args_str.extend(['--build-arg', f'{arg}={val}'])
    except KeyError:
        args_str = ''

    build = 'docker buildx build'
    command = build.split(' ') + args_str + ['-t', f'{tag}', '-f', f'{dockerfile}', f'{context}']

    try:
        options = '--no-cache' if config['NOCACHE'] else None
        assert options
        command += [f'{options}']
    except (KeyError, AssertionError):
        pass

    return command


def exec(command: str):
    assert len(command) > 0
    process = subprocess.Popen(
        command,
        stdout=sys.stdout,
        stderr=subprocess.STDOUT,
        universal_newlines=True,
    )
    process.communicate()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--config', type=str, required=True)
    args = parser.parse_args()

    cfg = parse(args.config)
    command = get_command_from_cfg(cfg)
    exec(command)
