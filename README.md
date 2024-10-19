#  Docker container for ROS 2 humble Hawksbill
## これは何？
皆さんご存知のROS 2 humble環境をDockerコンテナで持ち運べるリポジトリになります。提供パッケージ(ros_practice)はROS 2プログラミングを練習できます。

:::note warn
このブランチはMac OS用のROS コンテナです。Ubuntuで使用される場合はmasterブランチをご覧ください。
:::

### セットアップ
- docker
- docker-compose
### Dockerインストール方法
まず `curl` がaptからインストールされているか確認してください。そしたら以下のコマンドを
実行しましょう。
```bash
curl https://get.docker.com/ | sudo sh
```
dockerとdocker composeのバージョンを確認しましょう。
```bash
docker -v
docker compose -v
```
これでエラーメッセージ以外が表示されたら成功です！

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

> 2024年10月19日更新
