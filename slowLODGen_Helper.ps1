# Script: .\slowLODGen_Helper.ps1
param(
    [string]$PYFOUND = "0",
    [string]$YAMLFOUND = "0"
)

# basic checks
Write-Host "[ps] pypy.exe present: $PYFOUND"
Write-Host "[ps] LODGen_config.yaml present: $YAMLFOUND"
if ($PYFOUND  -ne "1") { Write-Host "[ps] ERROR: pypy.exe missing"; exit 1 }
if ($YAMLFOUND -ne "1") { Write-Host "[ps] ERROR: LODGen_config.yaml missing"; exit 1 }

$config = "LODGen_config.yaml"
$yamlRaw = Get-Content $config -Raw

function Get-Current($key) {
    if ($yamlRaw -match "(?m)^$key\s*:\s*(.+)$") { $matches[1].Trim('"') } else { $null }
}

function Fix-PluginsPath($path) {
    if ([string]::IsNullOrWhiteSpace($path)) { return $path }
    
    # If path ends with plugins.txt, return as-is
    if ($path -match "plugins\.txt$") { 
        return $path 
    }
    
    # If it's a directory path, append \plugins.txt
    if (Test-Path $path -PathType Container) {
        $fixedPath = Join-Path $path "plugins.txt"
        Write-Host "[ps] Directory detected, appending plugins.txt: $fixedPath"
        return $fixedPath
    }
    
    # If it's not an existing directory but doesn't end with plugins.txt, assume it's a folder path
    if (-not ($path -match "plugins\.txt$")) {
        $fixedPath = Join-Path $path "plugins.txt"
        Write-Host "[ps] Assuming directory path, appending plugins.txt: $fixedPath"
        return $fixedPath
    }
    
    return $path
}

# ---- game_folder ----
$currentGame = Get-Current "game_folder"
Write-Host "[ps] Current ~\game_folder\Data location: $currentGame"
$prompt = if ($currentGame) { "Press Enter to keep, or type new path" } else { "Enter path to Oblivion\Data (eg C:\Games\Oblivion\Data)" }
$newGame = Read-Host $prompt
if ([string]::IsNullOrWhiteSpace($newGame)) { $newGame = $currentGame }

# ---- plugins_txt_path ----
$currentPlugins = Get-Current "plugins_txt_path"
Write-Host "[ps] Current plugins_txt_path : $currentPlugins"
$prompt = if ($currentPlugins) { "Press Enter to keep, or type new path" } else { "Enter path to plugins.txt OR the folder containing it (eg C:\Users\<UserName>\AppData\Local\oblivion)" }
$newPlugins = Read-Host $prompt
if ([string]::IsNullOrWhiteSpace($newPlugins)) { 
    $newPlugins = $currentPlugins 
} else {
    # Fix the plugins path if user provided just a directory
    $newPlugins = Fix-PluginsPath $newPlugins
}

# update only if changed
$yaml = $yamlRaw
if (![string]::IsNullOrWhiteSpace($newGame) -and $newGame -ne $currentGame) {
    $yaml = $yaml -replace '(?m)^game_folder\s*:.*', "game_folder: `"$($newGame -replace '\\','\\')`""
}
if (![string]::IsNullOrWhiteSpace($newPlugins) -and $newPlugins -ne $currentPlugins) {
    $yaml = $yaml -replace '(?m)^plugins_txt_path\s*:.*', "plugins_txt_path: `"$($newPlugins -replace '\\','\\')`""
}
$yaml | Set-Content $config -Encoding UTF8

# final confirmation
Write-Host "`n[ps] Final values:"
Write-Host "    game_folder     : $(if ([string]::IsNullOrWhiteSpace($newGame)) { "<not set>" } else { $newGame })"
Write-Host "    plugins_txt_path: $(if ([string]::IsNullOrWhiteSpace($newPlugins)) { "<not set>" } else { $newPlugins })"

# Validate the plugins.txt file exists
if (![string]::IsNullOrWhiteSpace($newPlugins) -and !(Test-Path $newPlugins)) {
    Write-Host "[ps] WARNING: plugins.txt file not found at: $newPlugins" -ForegroundColor Yellow
    Write-Host "[ps] Please verify the path is correct before running slowLODGen.py" -ForegroundColor Yellow
}