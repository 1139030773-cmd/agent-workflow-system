#!/bin/bash
# Agent Workflow 发布脚本
# 用法: bash references/scripts/release.sh v1.5.0 "简短描述"
set -e

TAG=$1
DESC=${2:-"发布版本"}

if [ -z "$TAG" ]; then
  echo "用法: bash release.sh vX.Y.Z \"更新说明\""
  exit 1
fi

VERSION=${TAG#v}
REPO_DIR=$(cd "$(dirname "$0")/../.." && pwd)
GITHUB_REPO="1139030773-cmd/agent-workflow-system"

echo "=== 1. 版本号同步 ==="
cd "$REPO_DIR"
# 更新所有 JSON 版本号
find . -name "marketplace.json" -path "*/.github/*" -exec sed -i "s/\"version\":\"[^\"]*\"/\"version\":\"$VERSION\"/g" {} \;
find . -name "plugin.json" -path "*/.codex-plugin/*" -exec sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/g" {} \;
echo "版本号已统一为 $VERSION"

echo "=== 2. CHANGELOG 检查 ==="
if ! grep -q "## \[$VERSION\]" CHANGELOG.md; then
  echo "⚠️  CHANGELOG.md 缺少 [$VERSION] 条目，请手动添加后重试"
  exit 1
fi

echo "=== 3. 提交并推送 ==="
git add -A
git commit -m "release: $TAG — $DESC" || echo "(无新增改动)"
git push origin main

echo "=== 4. 打 Tag ==="
git tag -d "$TAG" 2>/dev/null || true
git push origin ":refs/tags/$TAG" 2>/dev/null || true
git tag -a "$TAG" -m "$TAG — $DESC"
git push origin "$TAG"

echo "=== 5. Codex 市场刷新 ==="
CODEX_CLI=""
if [ -d "$HOME/.codex/.sandbox-bin" ]; then
  CODEX_CLI=$(find "$HOME/.codex/.sandbox-bin" -name "codex-command-runner-*" \( -name "*.exe" -o -type f -executable \) 2>/dev/null | sort -V | tail -1)
fi
if [ -z "$CODEX_CLI" ]; then
  CODEX_CLI=$(command -v codex 2>/dev/null || true)
fi
if [ -n "$CODEX_CLI" ]; then
  GIT_SSL_BACKEND=openssl "$CODEX_CLI" plugin marketplace remove agent-workflow-system 2>/dev/null || true
  GIT_SSL_BACKEND=openssl "$CODEX_CLI" plugin marketplace add "$GITHUB_REPO"
  GIT_SSL_BACKEND=openssl "$CODEX_CLI" plugin add agent-workflow-system@agent-workflow-system
  echo "Codex 已更新"
else
  echo "⚠️  未找到 Codex CLI，跳过 Codex 更新"
fi

echo "=== 6. 验证 ==="
echo "Claude Code: .claude/skills/ 版本已同步"
echo "Codex: /plugins 可搜索 agent-workflow-system@agent-workflow-system"
echo "GitHub: https://github.com/$GITHUB_REPO/releases/tag/$TAG"
echo ""
echo "✅ 发布完成: $TAG"
