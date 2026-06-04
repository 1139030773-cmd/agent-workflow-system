# SessionEnd Hook 脚本
# 在会话正常关闭时自动记录时间戳到 RESUME.md
# 由 .claude/settings.local.json 中的 SessionEnd hook 调用

param(
    [string]$ProjectDir = "c:\Users\11390\Documents\New project"
)

$resumePath = Join-Path $ProjectDir "RESUME.md"

if (-not (Test-Path $resumePath)) {
    exit 0
}

try {
    $content = Get-Content $resumePath -Raw -Encoding UTF8
    $now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $marker = "`n- **last_session_end**: $now`n"

    # 更新 last_updated 时间戳
    $content = $content -replace '- \*\*last_updated\*\*:.*', "- **last_updated**: $(Get-Date -Format 'yyyy-MM-dd')"

    # 追加会话结束标记（如果还没有的话）
    if ($content -notmatch 'last_session_end') {
        $content += $marker
    } else {
        $content = $content -replace '- \*\*last_session_end\*\*:.*', "- **last_session_end**: $now"
    }

    Set-Content $resumePath -Value $content -Encoding UTF8 -NoNewline
    Write-Output "SessionEnd: RESUME.md checkpoint updated at $now"
} catch {
    Write-Output "SessionEnd: Failed to update RESUME.md - $_"
    exit 1
}
