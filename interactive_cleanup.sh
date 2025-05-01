
#!/bin/bash

SESSION="tamhome_interactive_cleanup"

# セッション作成（すでに存在する場合はスキップ）
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION

    # ペイン1：sigverse_ros_bridge
    tmux send-keys -t $SESSION 'env-sigverse' C-m
    tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION 'clear' C-m
    tmux send-keys -t $SESSION 'roslaunch sigverse_hsrb_utils sigverse_ros_bridge.launch' C-m

    # ペイン2：sigverse_ros_bridge
    tmux split-window -v -t $SESSION
    tmux send-keys -t $SESSION 'env-sigverse' C-m
    tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION C-l
    tmux send-keys -t $SESSION 'roslaunch sigverse_hsrb_utils bring_up.launch'

    # ペイン3: handyman.launch
    tmux select-pane -U  # 上のペインにフォーカス
    tmux split-window -h -t $SESSION
    tmux select-pane -D
    tmux split-window -h -t $SESSION
    tmux send-keys -t $SESSION 'env-sigverse' C-m
    tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION  C-l
    tmux send-keys -t $SESSION 'roslaunch tamhome_interactive_cleanup interactive_cleanup.launch'

    # ペイン4: object_detection.launch
    tmux select-pane -U
    tmux send-keys -t $SESSION 'cd ~/usr/object_detection_ws/' C-m
    tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    tmux send-keys -t $SESSION 'sleep 2' C-m
    tmux send-keys -t $SESSION C-l
    tmux send-keys -t $SESSION 'roslaunch tam_object_detection hsr_head_rgbd_lang_sam_service.launch'

    # tmux split-window -h -t $SESSION
    # tmux send-keys -t $SESSION 'env-sigverse' C-m
    # tmux send-keys -t $SESSION 'source /entrypoint.sh' C-m
    # tmux send-keys -t $SESSION 'cd ~/usr/tamhome_ws/' C-m
    # tmux send-keys -t $SESSION 'source devel/setup.bash' C-m
    # tmux send-keys -t $SESSION 'sleep 2' C-m
    # tmux send-keys -t $SESSION  C-l
    # tmux send-keys -t $SESSION 'roslaunch tam_mmaction2 simple_test.launch is_sigverse:=true max_distance:=0'


fi

# セッションにアタッチ
tmux attach-session -t $SESSION
