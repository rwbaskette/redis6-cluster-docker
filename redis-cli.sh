#!/bin/bash

redis-cli -c -p 30001,30002,30003,30004,30005,30006 -a "$REDIS_PASSWORD"
