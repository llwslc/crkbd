#!/bin/bash
# 自动拷贝 endless 到 vial-qmk/keyboards/endless 并编译烧录
set -e

# 进入脚本所在目录
cd "$(dirname "$0")"

# vial-qmk 目录变量
VIAL_QMK_DIR="./vial-qmk"
KEYBOARD_DIR="./endless"
KEYBOARDS_DIR="$VIAL_QMK_DIR/keyboards"
TARGET_DIR="$KEYBOARDS_DIR/endless"

if [ -d "$KEYBOARDS_DIR" ]; then
    echo "Removing all in $KEYBOARDS_DIR ..."
    rm -rf "$KEYBOARDS_DIR"/*
fi

# 拷贝 endless 目录
cp -r "$KEYBOARD_DIR" "$TARGET_DIR"
echo "Copied $KEYBOARD_DIR to $TARGET_DIR"

# 进入 vial-qmk 目录
cd "$VIAL_QMK_DIR"

# 清理 build 目录
echo "Cleaning up old build directory..."
rm -rf .build

# 编译
qmk compile -kb endless/rev1/standard -km vial
