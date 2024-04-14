#  Docker container for ROS 2 humble Hawkisible
皆さんご存知のROS 2 humble環境をDockerコンテナで持ち運べるリポジトリになります。提供パッケージ(ros_practice)はROS 2プログラミングを練習できます。
### セットアップ
- docker
- docker-compose

## コンテナ起動方法
シェルスクリプトから起動できます。
```bash
./entry_exec.sh
```
Nvidia製GPUドライバー付きのパソコンの場合は、-gpuオプションを付けてください。
```bash
./entry_exec.sh -gpu
```
これでコンテナに入れましたので、開発しましょう！

> 4月14日更新
