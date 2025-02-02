#!/bin/bash
set -eu

taplo lint --config ./assets/taplo.toml ./dist/config.toml
