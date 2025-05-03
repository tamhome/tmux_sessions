#!/bin/bash

SESSION="tamhome_human_navigation"

# セッション作成（すでに存在する場合はスキップ）
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION

    # ペイン1：左側：sigverse_ros_bridge
    tmux send-keys -t $SESSION 'env-sigverse' C-m
    tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION 'clear' C-m
    tmux send-keys -t $SESSION 'roslaunch sigverse_hsrb_utils sigverse_ros_bridge.launch' C-m

    tmux split-window -h -t $SESSION
    tmux send-keys -t $SESSION 'env-sigverse' C-m
    tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION 'clear' C-m
    tmux send-keys -t $SESSION 'roslaunch human_navigation human_navigation.launch'
fi

# セッションにアタッチ
tmux attach-session -t $SESSION