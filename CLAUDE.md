<!-- 每个新会话自动加载。不要删除。 -->

## 启动恢复检查

**只有以下情况才读 RESUME.md 走恢复流程：**

| 用户第一句话 | 行为 |
|-------------|------|
| "继续" / "接着" / "上次" / "恢复" | 读 RESUME.md → 按 5 字段格式展示任务 → 问「接下来想怎么做？」 |
| 沉默 / 明确新任务 | 跳过，不打扰 |

## 系统改动铁律

**只要改了系统文件，以下 7 步必须一口气做完，不等用户催：**

| # | 步骤 | 说明 |
|---|------|------|
| 1 | **三目录同步** | ① 根目录 `c:\Users\11390\Documents\New project\`（CHANGELOG/README/CLAUDE.md）② `plugins/agent-workflow-system/`（插件 CLAUDE.md 规则）③ `plugins/plugins/agent-workflow-system/`（plugin.json/skills） |
| 2 | **CHANGELOG** | 在对应版本条目下记录改动（Added/Changed/Fixed），**版本号必须与步骤 5 的 plugin.json 一致** |
| 3 | **README** | 如果改动影响功能描述，同步更新核心特性/版本表 |
| 4 | **RESUME.md** | 如果改动涉及任务状态变更，同步更新 checkpoint（last_updated / completed / next_step / phase） |
| 5 | **版本号** | 如果是新功能/breaking change，同步更新 `plugin.json` + `marketplace.json` 版本，**版本号必须与步骤 2 的 CHANGELOG 一致** |
| 6 | **commit + push** | 在 `plugins/` 仓库提交推送；新功能/breaking change 需打版本 tag |
| 7 | **版本一致性验证** | 运行 `.\validate-version.ps1`，通过（显示 ✅）才算完成。不通过 → 回去补步骤 2 或 5，不准跳过 |

> **步骤 2 和 5 互相交叉引用**：改 CHANGELOG 时想着 plugin.json，改 plugin.json 时想着 CHANGELOG。两个版本号互为锚点，忘了一个会自相矛盾。

> **步骤 7 是硬卡点**：不读文件、不跑 `git tag` 确认 = 没改完。AI 不能凭"我记得改过了"跳过这步。

**违反信号**: 用户问"README 更新了吗"、"CHANGELOG 补了吗"、"推送了吗"、"Release 呢" = 你漏步骤了。

**自动化原则**: 同一件事用户让我做超过 3 次 → 把它写成规则或脚本，下次自动执行，不再让用户提醒。
