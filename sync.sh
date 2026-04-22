#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: sync.sh {UPSTREAM_SOURCE_DIR}" >&2
	exit 1
fi

if ! [ -d "$1" ]; then
	echo "$1 does not existed or not a dir" >&2
	exit 1
fi

UPSTREAM_SOURCE_DIR="${1}"
if ! [ "$UPSTREAM_SOURCE_DIR" = "/" ]; then
	UPSTREAM_SOURCE_DIR="${UPSTREAM_SOURCE_DIR%%/}"
fi

[ -d "$UPSTREAM_SOURCE_DIR/drivers/rknpu" -a -d "$UPSTREAM_SOURCE_DIR/drivers/video/rockchip" -a -d "$UPSTREAM_SOURCE_DIR/drivers/media/platform/rockchip/hdmirx" ] || {
	echo "$UPSTREAM_SOURCE_DIR does not contain drivers/rknpu or drivers/video/rockchip or drivers/media/platform/rockchip/hdmirx" >&2
	exit 1
}

rm -rf drivers/rknpu drivers/video/rockchip drivers/media/platform/rockchip/hdmirx
mkdir -p drivers/rknpu drivers/video/rockchip drivers/media/platform/rockchip/hdmirx

echo "copy drivers/rknpu"
cp -a "$UPSTREAM_SOURCE_DIR/drivers/rknpu" drivers/
echo "copy drivers/video/rockchip"
cp -a "$UPSTREAM_SOURCE_DIR/drivers/video/rockchip" drivers/video/
echo "copy drivers/media/platform/rockchip/hdmirx"
cp -a "$UPSTREAM_SOURCE_DIR/drivers/media/platform/rockchip/hdmirx" drivers/media/platform/rockchip/

find include -type f | grep -v '^include/compat/' | xargs -n1 sh -c 'echo "copy $0" ; cp -a "'"$UPSTREAM_SOURCE_DIR"'/$0" "$0"'
