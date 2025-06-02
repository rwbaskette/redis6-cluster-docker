#!/bin/bash

redis-cli -c -p 6001,6002,6003,6004,6005,6006 -a "$REDIS_PASSWORD"
