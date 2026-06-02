# 状态机：合法跳转路径

## 状态定义

```
[入口] → 新手引导 → 项目总控 → 执行中 → 漂移审计 → 阶段收尾 → [结束]
              ↘         ↘         ↗           ↗
           学习教练   调试修复
```

## 合法跳转表

| 从 → 到 | workflow-system | newbie-guide | project-master | debug-fixer | learning-coach | drift-auditor | phase-closeout |
|-----------|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| **workflow-system** | — | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| **newbie-guide** | ✔ | — | ✔ | ✔ | ✔ | ✔ | ✔ |
| **project-master** | — | ✔ | — | ✔ | ✔ | ✔ | ✔ |
| **debug-fixer** | — | — | ✔ | — | — | ✔ | ✔ |
| **learning-coach** | — | — | — | — | — | ✔ | ✔ |
| **drift-auditor** | — | ✔ | ✔ | — | — | — | ✔ |
| **phase-closeout** | ✔ | ✔ | ✔ | — | — | — | — |

## 强制路径规则

1. **调试修复 → 漂移审计**：修复后如发现项目结构受影响，必须先过审计再回归。
2. **学习教练 → 漂移审计**：学习跑偏时，必须先审计再决定方向。
3. **任意技能 → 阶段收尾**：收尾前建议执行一次快速漂移审计（轻量）。
4. **debug-fixer / learning-coach → project-master**：执行者不得直接切到策划者。必须先通过 drift-auditor 或 workflow-system 中转。

## 违规跳转处理

1. 识别跳转请求是否在合法表中。
2. 若不在表中，拒绝跳转并建议合法路径。
3. 用户坚持时，强制走 drift-auditor 中转。
