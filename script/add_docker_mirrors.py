#!/usr/bin/env python3

"""Add docker mirrors from specific mirror file
"""
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('mirror_file', help='path of file that each line specify one mirror')
parser.add_argument('--config_file', help='config file of docker daemon', default='/etc/docker/daemon.json')
args = parser.parse_args()

# Read mirror list
with open(args.mirror_file) as f:
    mirror_lists = [line.rstrip() for line in f.readlines()]

# Read docker daemon configuration
docker_config = json.load(open(args.config_file))

# Set the attribute name of mirror configuration
attribute = 'registry-mirrors'

# If already configured mirrors, combine them
if attribute in docker_config:
    mirror_lists += docker_config[attribute]

# Remove dubplicates
mirror_lists = list(set(mirror_lists))

# Write mirror lists to json object
docker_config[attribute] = mirror_lists

# Save to config file
json.dump(docker_config, open(args.config_file, 'w'), indent=2)