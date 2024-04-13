#  Docker container for ROS 2 humble Hawkisible
## これは何？
皆さんご存知のROS 2 humble環境をDockerコンテナで持ち運べるリポジトリになります。提供パッケージ(tb3_vision)はOpenCVを使って遊べます。
### セットアップ
- docker
- docker-compose

## コンテナ起動方法
まずDockerコンテナを立てます
'''bash
docker compose up -d
'''
次にコンテナを起動します
'''bash
docker compose exec test_docker /bin/bash
'''

> 4月14日更新
