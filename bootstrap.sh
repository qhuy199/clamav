#!/bin/bash

# start clam service itself and the updater in background as daemon
freshclam && chown root:root /var/lib/clamav/*.* && freshclam -d
clamd
