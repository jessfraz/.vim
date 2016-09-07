#! /bin/bash
set -e

git submodule foreach git pull --recurse-submodules origin master
