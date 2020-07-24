#!/bin/bash

tmux new-session -d -s work

tmux new-window -t work:1
tmux new-window -t work:2
tmux new-window -t work:3


# Split second window in «work» session
tmux split-window -dv -p 50 -t work:2.0
tmux split-window -dh -p 50 -t work:2.1

tmux send-keys -t work:1. 'cd ~/Workspace/ && mc' C-m

tmux send-keys -t work:2.1 'uptime' C-m
tmux send-keys -t work:2.2 'cd ~/Workspace/' C-m
tmux send-keys -t work:2. 'cd ~/Desktop/' C-m

tmux send-keys -t work:3. 'htop' C-m


tmux select-window -t work:2
tmux -2 attach-session -t work
