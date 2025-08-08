#!/bin/bash
# 下载并解压指定 commit 的 vial-qmk，并建立软链接

set -e


COMMIT_ID="0f7eae3a556831d1f639d89b7a281ebf5c5a136b"
ZIP_URL="https://github.com/vial-kb/vial-qmk/archive/$COMMIT_ID.zip"
ZIP_FILE="vial-qmk.zip"
CLONE_DIR="vial-qmk"
TMP_LINK_TARGET="../../tmp"
KEYBOARDS_DIR="$CLONE_DIR/keyboards"
LINK_NAME="$KEYBOARDS_DIR/tmp"

# 进入脚本所在目录
cd "$(dirname "$0")"

# 清理旧目录
if [ -d "$CLONE_DIR" ]; then
    echo "Removing existing $CLONE_DIR directory..."
    rm -rf "$CLONE_DIR"
fi

# 下载 zip
echo "Downloading $ZIP_URL ..."
curl -L -o "$ZIP_FILE" "$ZIP_URL"

# 解压
unzip -q "$ZIP_FILE"
rm "$ZIP_FILE"

# 解压后目录名
mv "vial-qmk-$COMMIT_ID" "$CLONE_DIR"

# 建立软链接
mkdir -p "$KEYBOARDS_DIR"
ln -sfn "$TMP_LINK_TARGET" "$LINK_NAME"
echo "Created symlink: $LINK_NAME -> $TMP_LINK_TARGET"
