# TMUX SESSIONS for launch Tasks

- 以下のaliasを `~/.bashrc`に設定してください．
- パスは環境に沿って変更してください．
    - 以下は， `~/usr/tamhome_ws`の配下に， `src/` `env/` `tmux_sessions`があることを想定しております．

```bash
alias env-sigverse="apptainer shell --nv -B /run/user/1000,/var/lib/dbus/machine-id ~/usr/tamhome_ws/env/sandbox_sigverse/"
alias env-root-sigverse="apptainer shell --nv --fakeroot --writable ~/usr/tamhome_ws/env/sandbox_sigverse/"

alias session-interactive-cleanup="sh ~/usr/tamhome_ws/tmux_sessions/interactive_cleanup.sh"
alias session-human-navigation="sh ~/usr/tamhome_ws/tmux_sessions/human_navigation.sh"
alias session-handyman="sh ~/usr/tamhome_ws/tmux_sessions/handyman.sh"
```

- 以下のように実行すると，自動的にtmuxと，タスクの実行に必要なコマンドが実行されます．

```bash
session-handyman
```
