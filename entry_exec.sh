#!/bin/bash

#pulseaudioサーバーをデーモンで起動
pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon

# イメージが存在するかどうかを確認
image_name="humble"
container="humble-test"
option=$1

if [[ $option == "-gpu" ]]; then
    container="${container}-gpu"
    image_name="${image_name}:gpu"
else
    image_name="${image_name}:cpu"
fi

image_exists=$(docker images -q "${image_name}")

# 条件分岐でイメージが存在するかを判断
if [ -n "$image_exists" ]; then
  # イメージが存在する場合の処理
  echo "イメージ"${image_name}"を見つけたよ！"${image_name}"を実行するね！"
  docker compose up -d $container
else
  # イメージが存在しない場合の処理
  echo "イメージ" ${image_name} "は見つかりませんでした。別の方法でコンテナを起動するよ！"
  docker compose up -d --build $container
fi
docker compose exec $container /bin/bash
pulseaudio --kill
