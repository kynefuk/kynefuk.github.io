---
title: buildxコマンドのメモ
tags:
  - docker
  - buildx
---

## ビルダーインスタンス作成
buildkitの機能をフルに使いたい場合は、`--driver docker-container`を指定してビルダーインスタンスを作成する。

```
docker buildx create --driver docker-container --name container-builder --use
```

## ビルダーインスタンス確認
`*`が付いているインスタンスが使用されている。

```
docker buildx ls
NAME/NODE            DRIVER/ENDPOINT             STATUS   PLATFORMS
container-builder *  docker-container                     
  container-builder0 unix:///var/run/docker.sock inactive 
desktop-linux        docker                               
  desktop-linux      desktop-linux               running  linux/arm64, linux/amd64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
default              docker                               
  default            default                     running  linux/arm64, linux/amd64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```


`STATUS`が`inactive`になっているが、これはbuild実行時にrunnningになる。

明示的に`running`にしたい場合は`--bootstrap`を実行する。
```
docker buildx inspect --bootstrap
```

## ビルド
buildxによるビルドでは通常のdocker buildと異なり、`--output`を指定する必要がある。

| `--output`のtype | 意味                                     |
| ---------------- | ---------------------------------------- |
| local            | ビルド結果をローカルに出力する           |
| docker           | ビルド結果をdockerイメージとして出力する |
| registry         | ビルド結果をコンテナレジストリに出力する |
| oci              | ビルド結果をOCIイメージとして出力する    |
| image            | ビルド結果をコンテナ出力する             |

| `--output`のエイリアス | 意味                     |
| ---------------------- | ------------------------ |
| --load                 | `--output=type=docker`   |
| --push                 | `--output=type=registry` |

### local
ビルド結果のファイルを全てローカルに出力する。
```
docker buildx build -t hoge --output type=local,dest=/tmp .
```

### docker
ビルド結果をDocker image specificationに基づいたtar形式で出力する。
`type=docker`を指定した場合は、multiplatformなイメージは出力できない。
```
docker buildx build -t hoge --output type=docker,dest=hoge-image .
```

### oci
ビルド結果をOCI image layoutに基づいたtar形式で出力する。
```
docker buildx build -t hoge --output type=oci,dest=hoge-oci .
```

### image
ビルド結果をコンテナイメージとして出力する。
`docker`ドライバーを使用した場合はdockerイメージが出力される。
`push=true`を指定すると、ビルド結果をレジストリにpushする。
```
docker buildx build -t hoge --output type=image,name=hoge/fuga push=true .
```

### registry
`type=image,push=true`の短縮形