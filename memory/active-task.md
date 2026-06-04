---
name: active-task
description: 当前活跃任务追踪 — 任务名称、阶段、进度、下一步
metadata: 
  node_type: memory
  type: project
  originSessionId: 54b17141-0ce4-4830-9c24-fd55a0d2bc26
---

# 活跃任务

此文件追踪当前正在进行的任务。与项目根目录 `RESUME.md` 保持同步。

**Why:** 任务状态需要在多个会话之间持久化，确保关窗口不丢任务。
**How to apply:** 工作过程中持续更新此文件，新会话时首先检查此文件确认是否有未完成任务。

## 当前状态

- **是否有活跃任务**: 否
- **任务名称**: 无
- **阶段**: 无
- **下一步**: 无

## 更新规则

- 每次完成一个重要步骤后更新
- 阶段变化时更新
- 遇到阻塞时更新
- 与 `RESUME.md` 保持同步

## 关联

- [[session-recovery]] — 恢复流程
- 项目 `RESUME.md` — 任务恢复点（主要 checkpoint）
- 项目 `CLAUDE.md` — 启动自检
