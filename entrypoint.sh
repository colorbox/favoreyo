#!/bin/bash
set -e

rm -f /favoreyo/tmp/pids/server.pid

exec "$@"
