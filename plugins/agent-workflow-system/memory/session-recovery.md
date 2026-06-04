---
name: session-recovery
description: 新会话启动时的任务恢复流程 — 检测 RESUME.md 并引导用户恢复或新建任务
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54b17141-0ce4-4830-9c24-fd55a0d2bc26
---

# 会话恢复流程

每次新会话启动时，AI 必须先读取项目根目录的 `RESUME.md` 文件。

## 检测逻辑

1. 读取 `RESUME.md`
2. 查看 `status` 字段
3. 根据状态执行对应操作

## 状态与行为

| status | 行为 |
|--------|------|
| `inactive` | 正常开始，不触发恢复 |
| `active` | 展示四选项：继续 / 暂缓 / 放弃 / 新项目 |
| `paused` | 静默跳过（用户主动暂缓），不打扰 |
| `completed` | 正常开始 |
| `abandoned` | 正常开始（用户已放弃） |

## 四个选项的精确行为

- **继续**：读取 RESUME.md 全部内容，载入任务上下文，从 next_step 继续
- **暂缓**：在 RESUME.md 记录 `paused_at`，状态改为 `paused`，本窗口自由工作
- **放弃**：状态改为 `abandoned`，记录时间，不删除历史信息
- **新项目**：状态改为 `completed`，归档旧任务摘要，正常开始新工作

## 关联

- [[active-task]] — 当前活跃任务详情
- 项目文件 `CLAUDE.md` — 启动自检指令（每次自动加载）
- 项目文件 `RESUME.md` — 任务恢复点
