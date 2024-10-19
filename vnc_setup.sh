#!/bin/bash
#!/bin/bash

# 環境変数を設定
export USER=$(whoami)
export DISPLAY=:1

# 初回起動時にパスワードを設定
if [ ! -f /home/${USER}/.vnc/passwd ]; then
    mkdir -p /home/${USER}/.vnc
    echo "vncpassword" | vncpasswd -f > /home/${USER}/.vnc/passwd
    chmod 600 /home/${USER}/.vnc/passwd
fi

# VNCサーバーを起動
vncserver :1 -geometry 1280x800 -depth 24

# xrdb の設定を VNCサーバー起動後に実行
xrdb /home/${USER}/.Xresources

# Webインターフェースを起動
websockify --web=/usr/share/novnc/ --wrap-mode=ignore 8080 localhost:5901
