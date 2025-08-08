#!/bin/bash
# 初始化脚本：浅拷贝 vial-qmk 仓库并记录 commit id

REPO_URL="https://github.com/vial-kb/vial-qmk"
CLONE_DIR="vial-qmk"
COMMIT_FILE="vial-qmk_commit.txt"

# 进入脚本所在目录
cd "$(dirname "$0")"

# 如果已存在则删除旧目录
if [ -d "$CLONE_DIR" ]; then
    echo "Removing existing $CLONE_DIR directory..."
    rm -rf "$CLONE_DIR"
fi

echo "Cloning $REPO_URL (depth=1)..."
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

if [ $? -ne 0 ]; then
    echo "Clone failed!"
    exit 1
fi

cd "$CLONE_DIR"
COMMIT_ID=$(git rev-parse HEAD)
cd ..

echo "$COMMIT_ID" > "$COMMIT_FILE"
echo "Cloned commit: $COMMIT_ID (saved to $COMMIT_FILE)"
