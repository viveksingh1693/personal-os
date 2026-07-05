param(
    [string]$Root = "V:\projects\personal-os"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================="
Write-Host " Personal OS Documentation Bootstrap"
Write-Host "========================================="
Write-Host ""

$directories = @(

# Root Docs
"docs",

# ADR
"docs\adr",

# Architecture
"docs\architecture",

# API
"docs\api",

# Modules
"docs\modules",

# Agents
"docs\agents",

# Plugins
"docs\plugins",

# Workflows
"docs\workflows",

# SDK
"docs\sdk",

# Tutorials
"docs\tutorials",

# Diagrams
"docs\diagrams",

# Decisions
"docs\decisions",

# Finance Module
"docs\modules\finance",

# Health Module
"docs\modules\health",

# Goals Module
"docs\modules\goals",

# Calendar Module
"docs\modules\calendar",

# Shopping Module
"docs\modules\shopping",

# Knowledge Module
"docs\modules\knowledge",

# Travel Module
"docs\modules\travel",

# Career Module
"docs\modules\career",

# Journal Module
"docs\modules\journal",

# Investments Module
"docs\modules\investments"
)

$files = @(

# Root Docs

"docs\README.md"

# Architecture

"docs\architecture\VISION.md",
"docs\architecture\ARCHITECTURE.md",
"docs\architecture\PROJECT.md",
"docs\architecture\IMPLEMENTATION_GUIDE.md",
"docs\architecture\AI_DEVELOPMENT_GUIDE.md",

# ADR

"docs\adr\README.md",
"docs\adr\ADR-0001-kernel-first-architecture.md",
"docs\adr\ADR-0002-component-model.md",
"docs\adr\ADR-0003-capability-registry.md",
"docs\adr\ADR-0004-event-driven-communication.md",
"docs\adr\ADR-0005-hexagonal-architecture.md",
"docs\adr\ADR-0006-memory-vs-knowledge.md",
"docs\adr\ADR-0007-modular-monolith.md",
"docs\adr\ADR-0008-technology-stack.md",
"docs\adr\ADR-0009-api-design.md",
"docs\adr\ADR-0010-testing-strategy.md",

# SDK

"docs\sdk\MODULE_SDK.md",
"docs\sdk\PLUGIN_SDK.md",
"docs\sdk\AGENT_SDK.md",
"docs\sdk\WORKFLOW_SDK.md",
"docs\sdk\TOOL_SDK.md",

# API

"docs\api\API.md",
"docs\api\AUTHENTICATION.md",
"docs\api\ERROR_CODES.md",

# Agents

"docs\agents\AGENTS.md",
"docs\agents\PLANNER_AGENT.md",
"docs\agents\MEMORY_AGENT.md",
"docs\agents\FINANCE_AGENT.md",

# Workflows

"docs\workflows\WORKFLOW_ENGINE.md",
"docs\workflows\COMMON_WORKFLOWS.md",

# Tutorials

"docs\tutorials\GETTING_STARTED.md",
"docs\tutorials\CREATE_MODULE.md",
"docs\tutorials\CREATE_PLUGIN.md",
"docs\tutorials\CREATE_AGENT.md",

# Diagrams

"docs\diagrams\architecture.drawio",
"docs\diagrams\component.drawio",
"docs\diagrams\event-flow.drawio",

# Decisions

"docs\decisions\DECISION_ENGINE.md",
"docs\decisions\DECISION_RULES.md"
)

$moduleDocs = @(
"README.md",
"SPECIFICATION.md",
"DATA_MODEL.md",
"EVENTS.md",
"API.md",
"WORKFLOWS.md",
"DECISIONS.md",
"TEST_PLAN.md"
)

$modules = @(
"finance",
"health",
"goals",
"calendar",
"shopping",
"knowledge",
"travel",
"career",
"journal",
"investments"
)

foreach($dir in $directories)
{
    New-Item `
        -ItemType Directory `
        -Force `
        -Path (Join-Path $Root $dir) | Out-Null
}

foreach($file in $files)
{
    $path = Join-Path $Root $file

    if(!(Test-Path $path))
    {
        New-Item `
            -ItemType File `
            -Path $path | Out-Null
    }
}

foreach($module in $modules)
{
    $modulePath = Join-Path $Root "docs\modules\$module"

    foreach($doc in $moduleDocs)
    {
        $file = Join-Path $modulePath $doc

        if(!(Test-Path $file))
        {
            New-Item `
                -ItemType File `
                -Path $file | Out-Null
        }
    }
}

Write-Host ""
Write-Host "Documentation structure created successfully."
Write-Host ""