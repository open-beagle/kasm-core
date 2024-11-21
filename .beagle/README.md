# kasm-core

<https://github.com/kasmtech/workspaces-core-images>

```bash
git remote add upstream git@github.com:kasmtech/workspaces-core-images.git

git fetch upstream

git merge upstream/release/1.16.0
```

## build

```bash
docker pull registry.cn-qingdao.aliyuncs.com/wod/debian:bookworm-slim-amd64 && \
docker build \
  --no-cache \
  --build-arg BASE=registry.cn-qingdao.aliyuncs.com/wod/debian:bookworm-slim-amd64 \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=1.16.0 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=amd64 \
  --build-arg BG_IMG=bg_debian.svg \
  --build-arg DISTRO=debian \
  --build-arg LANG=zh_CN.UTF-8 \
  --build-arg LANGUAGE="zh_CN:zh" \
  --build-arg LC_ALL=zh_CN.UTF-8 \
  --build-arg TZ=Asia/Shanghai \
  -t registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-amd64 \
  -f .beagle/core-debian-bookworm.dockerfile \
  . && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-amd64

docker build \
  --build-arg BASE=registry.cn-qingdao.aliyuncs.com/wod/debian:bookworm-slim-arm64 \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=1.16.0 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=arm64 \
  --build-arg BG_IMG=bg_debian.svg \
  --build-arg DISTRO=debian \
  --build-arg LANG=zh_CN.UTF-8 \
  --build-arg LANGUAGE="zh_CN:zh" \
  --build-arg LC_ALL=zh_CN.UTF-8 \
  --build-arg TZ=Asia/Shanghai \
  -t registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-arm64 \
  -f .beagle/core-debian-bookworm.dockerfile \
  . && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-arm64

# debug
docker pull registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-amd64 && \
docker run -it --rm \
  -v $PWD:/go/src/github.com/open-beagle/kasm-core \
  -w /go/src/github.com/open-beagle/kasm-core \
  --entrypoint=/bin/bash \
  registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-v1.16.0-amd64
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=${S3_ENDPOINT_ALIYUN} \
  -e PLUGIN_ACCESS_KEY=${S3_ACCESS_KEY_ALIYUN} \
  -e PLUGIN_SECRET_KEY=${S3_SECRET_KEY_ALIYUN} \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="kasm-core" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=${S3_ENDPOINT_ALIYUN} \
  -e PLUGIN_ACCESS_KEY=${S3_ACCESS_KEY_ALIYUN} \
  -e PLUGIN_SECRET_KEY=${S3_SECRET_KEY_ALIYUN} \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="kasm-core" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```

## images

```bash
# kasmweb/core-debian-bookworm
docker pull kasmweb/core-debian-bookworm:1.16.0 && \
docker tag kasmweb/core-debian-bookworm:1.16.0 registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-1.16.0-amd64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-1.16.0-amd64

docker pull --platform=linux/arm64 kasmweb/core-debian-bookworm:1.16.0 && \
docker tag kasmweb/core-debian-bookworm:1.16.0 registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-1.16.0-arm64 && \
docker push registry.cn-qingdao.aliyuncs.com/wod/kasmweb:core-debian-bookworm-1.16.0-arm64
```
