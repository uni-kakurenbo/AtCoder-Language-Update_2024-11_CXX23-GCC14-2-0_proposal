#!/bin/bash

echo a

(
    echo b

    exit 0

    echo c
)

echo d
