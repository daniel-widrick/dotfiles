#!/usr/bin/bash

ps -ef | grep way | awk '{print $2}' | xargs kill
sleep 5
