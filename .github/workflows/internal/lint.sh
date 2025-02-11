#!/bin/bash
set -eu

taplo lint --config ./assets/taplo.toml "./dist/$1/config.toml"
