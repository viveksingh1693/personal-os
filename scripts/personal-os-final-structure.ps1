param(
    [string]$Root = "V:\projects\personal-os"
)

$dirs = @(
"apps","apps\mobile","apps\web","apps\desktop","apps\cli",
"backend","backend\api","backend\bootstrap","backend\gateway","backend\middleware","backend\config",
"kernel","kernel\runtime","kernel\lifecycle","kernel\registry","kernel\capability","kernel\discovery","kernel\dependency","kernel\events","kernel\workflow","kernel\memory","kernel\decision","kernel\knowledge","kernel\telemetry","kernel\configuration","kernel\security","kernel\scheduler",
"platform","platform\ai","platform\authentication","platform\authorization","platform\cache","platform\configuration","platform\database","platform\logging","platform\messaging","platform\monitoring","platform\notifications","platform\persistence","platform\scheduler","platform\storage","platform\telemetry","platform\utilities",
"components","components\modules","components\plugins","components\agents","components\tools","components\workflows",
"components\modules\finance","components\modules\health","components\modules\goals","components\modules\calendar","components\modules\shopping","components\modules\knowledge","components\modules\journal","components\modules\travel","components\modules\career","components\modules\investments","components\modules\subscriptions","components\modules\notifications",
"components\plugins\telegram","components\plugins\whatsapp","components\plugins\gmail","components\plugins\google-calendar","components\plugins\browser","components\plugins\github","components\plugins\csv","components\plugins\pdf","components\plugins\ocr","components\plugins\web-crawler",
"components\agents\planner","components\agents\finance","components\agents\memory","components\agents\health","components\agents\shopping","components\agents\research","components\agents\calendar","components\agents\notification","components\agents\orchestrator",
"components\tools\search","components\tools\browser","components\tools\ocr","components\tools\calculator","components\tools\currency","components\tools\weather","components\tools\filesystem",
"components\workflows\finance","components\workflows\health","components\workflows\onboarding","components\workflows\reminders",
"sdk","sdk\component-sdk","sdk\module-sdk","sdk\plugin-sdk","sdk\workflow-sdk","sdk\tool-sdk","sdk\memory-sdk","sdk\event-sdk","sdk\agent-sdk",
"docs","docs\adr","docs\api","docs\architecture","docs\agents","docs\modules","docs\plugins","docs\workflows","docs\decisions","docs\diagrams","docs\tutorials",
"infrastructure","infrastructure\docker","infrastructure\kubernetes","infrastructure\terraform","infrastructure\monitoring","infrastructure\scripts","infrastructure\local",
"examples","tests","tests\unit","tests\integration","tests\contract","tests\performance","tests\e2e","benchmarks","scripts",".github",".github\workflows",".github\ISSUE_TEMPLATE"
)

$files=@(
"README.md","VISION.md","PROJECT.md","ARCHITECTURE.md","IMPLEMENTATION_GUIDE.md","AI_DEVELOPMENT_GUIDE.md","DATA_MODEL.md","EVENT_MODEL.md","MEMORY.md","DECISION_ENGINE.md","WORKFLOW_ENGINE.md","MODULE_SDK.md","PLUGIN_SDK.md","AGENTS.md","API.md","CONTRIBUTING.md","CHANGELOG.md","CODE_OF_CONDUCT.md","SECURITY.md","LICENSE","docker-compose.yml","Makefile","pyproject.toml",".env.example",".gitignore",".editorconfig",".github\PULL_REQUEST_TEMPLATE.md"
)

Write-Host "Creating Personal OS structure in $Root"
foreach($d in $dirs){
    New-Item -ItemType Directory -Force -Path (Join-Path $Root $d) | Out-Null
}
foreach($f in $files){
    $p=Join-Path $Root $f
    $parent=Split-Path $p -Parent
    if(!(Test-Path $parent)){New-Item -ItemType Directory -Force -Path $parent|Out-Null}
    if(!(Test-Path $p)){New-Item -ItemType File -Path $p|Out-Null}
}
Write-Host "Done."
