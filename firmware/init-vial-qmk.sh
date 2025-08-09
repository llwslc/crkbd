
#!/bin/bash
# 克隆 vial-qmk 仓库（depth=1），并初始化 submodule
set -e

REPO_URL="git@github.com:vial-kb/vial-qmk.git"
CLONE_DIR="vial-qmk"

# 进入脚本所在目录
cd "$(dirname "$0")"

# 清理旧目录
if [ -d "$CLONE_DIR" ]; then
    echo "Removing existing $CLONE_DIR directory..."
    rm -rf "$CLONE_DIR"
fi

echo "Cloning $REPO_URL (depth=1)..."
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

cd "$CLONE_DIR"
echo "Initializing submodules ..."
git submodule update --init --recursive --depth 1

echo "Setting up QMK environment..."
qmk setup
