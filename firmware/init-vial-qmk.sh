#!/bin/bash
# 初始化脚本：浅拷贝 vial-qmk 仓库并记录 commit id，支持指定 commit

REPO_URL="git://github.com/vial-kb/vial-qmk.git"
CLONE_DIR="vial-qmk"
COMMIT_FILE="vial-qmk-commit.txt"

# 进入脚本所在目录
cd "$(dirname "$0")"

# 如果已存在则删除旧目录
if [ -d "$CLONE_DIR" ]; then
    echo "Removing existing $CLONE_DIR directory..."
    rm -rf "$CLONE_DIR"
fi

# 如果有 commit id 文件，则按该 commit 克隆
if [ -f "$COMMIT_FILE" ]; then
    COMMIT_ID=$(cat "$COMMIT_FILE")
    echo "Found commit id: $COMMIT_ID, cloning that commit..."
    git clone "$REPO_URL" "$CLONE_DIR"
    if [ $? -ne 0 ]; then
        echo "Clone failed!"
        exit 1
    fi
    cd "$CLONE_DIR"
    git checkout "$COMMIT_ID"
    cd ..
    echo "Checked out commit: $COMMIT_ID (from $COMMIT_FILE)"
else
    echo "No commit id file, cloning latest (depth=1)..."
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
fi
