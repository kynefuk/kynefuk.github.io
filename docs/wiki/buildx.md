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

``` py title="bubble_sort.py"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```


`STATUS`が`inactive`になっているが、これはbuild実行時にrunnningになる。

明示的に`running`にしたい場合は`--bootstrap`を実行する。
``` 
docker buildx inspect --bootstrap
```

