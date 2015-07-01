
tmux new-window        -t ${DEFAULT_SESSION}:0 -k -n devops "${WORK_CMD}";
tmux split-window -h   -t ${DEFAULT_SESSION}:0 "${WORK_CMD}";
tmux split-window -v   -t ${DEFAULT_SESSION}:0 "${WORK_CMD}";
