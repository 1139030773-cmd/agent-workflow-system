# 项目指令

<!-- 本文件在每个新会话启动时自动加载。不要删除。 -->

## 🔍 会话启动自检（每次新窗口必执行）

**你必须先执行以下步骤，再回复用户任何内容：**

1. 读取 `RESUME.md`
2. 检查 `status` 字段：
   - 如果 `status: active` → 告诉用户发现了未完成任务，展示四个选项
   - 如果 `status: inactive` 或文件不存在 → 正常开始，不触发恢复流程

### 当检测到活跃任务时的回复模板

```
⚠️  检测到上次未完成的任务

| 项目 | 内容 |
|------|------|
| **任务名称** | {从 RESUME.md 读取} |
| **当前阶段** | {从 RESUME.md 读取} |
| **已完成** | {从 RESUME.md 读取} |
| **下一步** | {从 RESUME.md 读取} |
| **最后活动** | {从 RESUME.md 读取} |

你想怎么做？
A. **继续** — 载入任务状态，接着上次的进度做
B. **暂缓** — 保留任务进度，本窗口先做别的事（RESUME.md 保持 active）
C. **放弃** — 删除此任务的恢复点（将 RESUME.md 状态改为 archived）
D. **新项目** — 归档旧任务（标记为 completed），开始全新项目
```

**重要规则：**
- 用户选 A：读 RESUME.md 获取完整上下文，继续执行
- 用户选 B：在 RESUME.md 中追加 `paused_at: {时间}`，状态保持 active，本窗口自由工作
- 用户选 C：将 RESUME.md 的 status 改为 `abandoned`，追加 `abandoned_at: {时间}`
- 用户选 D：将 RESUME.md 的 status 改为 `completed`，清空 active 任务信息，正常开始

## 📝 自动 checkpoint

**在整个会话过程中，每完成一个重要步骤后，必须更新 `RESUME.md`：**
- 更新 `last_updated` 时间戳
- 更新 `completed` 完成项列表
- 更新 `next_step` 下一步
- 如果阶段变化，更新 `phase`
- 保持 `status: active`

不需要用户提醒，这是你的自动行为。

## 🔗 相关文件

- `RESUME.md` — 任务恢复点（自动 checkpoint）
- `PROJECT.md` — 项目目标与范围
- `TASK_QUEUE.md` — 详细任务队列
- `DECISIONS.md` — 架构决策记录
- `STATE_SNAPSHOT.md` — 状态快照
- `.claude/skills/` — 工作流技能系统
