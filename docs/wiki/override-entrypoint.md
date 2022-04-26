---
title: コンテナイメージのentrypointを上書きしてrunする
tags:
  - docker
---

`--entrypoint`を指定することでコンテナイメージに設定された`ENTRYPOINT`を上書きしてコンテナを起動できる。
注意点として、`--entrypoint`はコンテナイメージ名より前に指定する必要がある。

```
# /bin/bash -c sleep infinityを実行
docker run -d --privileged --name ubuntu --entrypoint='/bin/bash' ubuntu -c 'sleep infinity'
```