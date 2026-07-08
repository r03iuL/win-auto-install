# =========================================================
# installer.ps1
# Interactive Setup Menu (Hardware Buffer Scroll / Optimized)
# =========================================================

Clear-Host
[Console]::CursorVisible = $false

# Ensure terminal is tall enough for the UI
if ($Host.UI.RawUI.WindowSize.Height -lt 32) {
    $size = $Host.UI.RawUI.WindowSize
    $size.Height = 32
    try { $Host.UI.RawUI.WindowSize = $size } catch {}
}

$menuItems = @(
    [PSCustomObject]@{ Name = "7-Zip"; ID = "7zip.7zip"; Selected = $true }
    [PSCustomObject]@{ Name = "AB Download Manager"; ID = "amir1376.ABDownloadManager"; Selected = $true }
    [PSCustomObject]@{ Name = "Brave Browser"; ID = "Brave.Brave"; Selected = $true }
    [PSCustomObject]@{ Name = "Chocolatey"; ID = "Chocolatey.Chocolatey"; Selected = $true }
    [PSCustomObject]@{ Name = "Discord"; ID = "Discord.Discord"; Selected = $true }
    [PSCustomObject]@{ Name = "Docker Desktop"; ID = "Docker.DockerDesktop"; Selected = $true }
    [PSCustomObject]@{ Name = "FxSound"; ID = "FxSound.FxSound"; Selected = $true }
    [PSCustomObject]@{ Name = "Git"; ID = "Git.Git"; Selected = $true }
    [PSCustomObject]@{ Name = "Glary Utilities"; ID = "Glarysoft.GlaryUtilities"; Selected = $true }
    [PSCustomObject]@{ Name = "Google Chrome"; ID = "Google.Chrome"; Selected = $true }
    [PSCustomObject]@{ Name = "HEVC Video Extensions"; ID = "9n4wgh0z6vhq"; Selected = $true }
    [PSCustomObject]@{ Name = "LocalSend"; ID = "LocalSend.LocalSend"; Selected = $true }
    [PSCustomObject]@{ Name = "MouseKey (Remap Buttons)"; ID = "9PHM28LJDZF5"; Selected = $true }
    [PSCustomObject]@{ Name = "Mozilla Firefox"; ID = "Mozilla.Firefox"; Selected = $true }
    [PSCustomObject]@{ Name = "Node.js (Latest)"; ID = "OpenJS.NodeJS"; Selected = $true }
    [PSCustomObject]@{ Name = "OBS Studio"; ID = "OBSProject.OBSStudio"; Selected = $true }
    [PSCustomObject]@{ Name = "Postman"; ID = "Postman.Postman"; Selected = $true }
    [PSCustomObject]@{ Name = "PotPlayer"; ID = "Daum.PotPlayer"; Selected = $true }
    [PSCustomObject]@{ Name = "Power Switcher (Win10 Slider)"; ID = "9n9blztbxj47"; Selected = $true }
    [PSCustomObject]@{ Name = "PowerShell 7"; ID = "Microsoft.PowerShell"; Selected = $true }
    [PSCustomObject]@{ Name = "qBittorrent"; ID = "qBittorrent.qBittorrent"; Selected = $true }
    [PSCustomObject]@{ Name = "QuickLook (Spacebar Preview)"; ID = "QL-Win.QuickLook"; Selected = $true }
    [PSCustomObject]@{ Name = "Sublime Text 4"; ID = "SublimeHQ.SublimeText.4"; Selected = $true }
    [PSCustomObject]@{ Name = "Telegram Desktop"; ID = "Telegram.TelegramDesktop"; Selected = $true }
    [PSCustomObject]@{ Name = "TranslucentTB"; ID = "CharlesMilette.TranslucentTB"; Selected = $true }
    [PSCustomObject]@{ Name = "Visual Studio Code"; ID = "Microsoft.VisualStudioCode"; Selected = $true }
    [PSCustomObject]@{ Name = "VLC Media Player"; ID = "VideoLAN.VLC"; Selected = $true }
    [PSCustomObject]@{ Name = "WhatsApp"; ID = "WhatsApp.WhatsApp"; Selected = $true }
    [PSCustomObject]@{ Name = "Windows Terminal"; ID = "Microsoft.WindowsTerminal"; Selected = $true }
    [PSCustomObject]@{ Name = "Zoom"; ID = "Zoom.Zoom"; Selected = $true }
    [PSCustomObject]@{ Name = "LAUNCH: Chris Titus Windows Utility"; ID = "SCRIPT_TITUS"; Selected = $true }
)

$displayCount = 20
$topIndex = 0
$index = 0
$w = [Console]::BufferWidth

function Draw-Row($idx, $top, $isActive) {
    $screenY = 8 + ($idx - $top)
    [Console]::SetCursorPosition(0, $screenY)
    if ($idx -lt 0 -or $idx -ge $menuItems.Count) { Write-Host (" " * $w) -NoNewline -BackgroundColor Black; return }
    $item = $menuItems[$idx]
    $checkbox = if ($item.Selected) { "[X]" } else { "[ ]" }
    $checkColor = if ($item.Selected) { "Green" } else { "DarkGray" }
    $pad = " " * [Math]::Max(0, 60 - $item.Name.Length)
    if ($isActive) {
        Write-Host " > " -NoNewline -ForegroundColor Cyan -BackgroundColor Black
        Write-Host "$checkbox " -NoNewline -ForegroundColor $checkColor -BackgroundColor Black
        Write-Host "$($item.Name)$pad" -NoNewline -ForegroundColor Black -BackgroundColor Cyan
    } else {
        Write-Host "   " -NoNewline -BackgroundColor Black
        Write-Host "$checkbox " -NoNewline -ForegroundColor $checkColor -BackgroundColor Black
        Write-Host "$($item.Name)$pad" -NoNewline -ForegroundColor Gray -BackgroundColor Black
    }
}

function Draw-Footer() {
    [Console]::SetCursorPosition(0, 28)
    $maxView = [Math]::Min($topIndex + $displayCount, $menuItems.Count)
    $msg = "--- Showing $($topIndex + 1) to $($maxView) of $($menuItems.Count) ---"
    $pad = " " * [Math]::Max(0, $w - $msg.Length)
    Write-Host "$msg$pad" -NoNewline -ForegroundColor DarkGray -BackgroundColor Black
}

[Console]::SetCursorPosition(0, 0)
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "             WINDOWS APP INSTALLATION MENU               " -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green
Write-Host " Use [UP/DOWN Arrows] to navigate                        " -ForegroundColor DarkGray
Write-Host " Use [SPACEBAR] to check/uncheck an option               " -ForegroundColor DarkGray
Write-Host " Press [ENTER] to confirm selections and start           " -ForegroundColor DarkGray
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "                                                         "

for ($i = 0; $i -lt $displayCount; $i++) { Draw-Row $i $topIndex ($i -eq $index) }
Draw-Footer

$running = $true
while ($running) {
    [Console]::SetCursorPosition(0, 30)
    $key = [Console]::ReadKey($true)
    $oldIndex = $index
    $oldTop = $topIndex
    switch ($key.Key) {
        "UpArrow" { if ($index -gt 0) { $index-- } else { $index = $menuItems.Count - 1; $topIndex = $menuItems.Count - $displayCount; if ($topIndex -lt 0) { $topIndex = 0 } } }
        "DownArrow" { if ($index -lt $menuItems.Count - 1) { $index++ } else { $index = 0; $topIndex = 0 } }
        "Spacebar" { $menuItems[$index].Selected = -not $menuItems[$index].Selected; Draw-Row $index $topIndex $true }
        "Enter" { $running = $false }
    }
    if ($index -lt $topIndex) { $topIndex = $index }
    elseif ($index -ge $topIndex + $displayCount) { $topIndex = $index - $displayCount + 1 }
    if ($topIndex -ne $oldTop) {
        for ($i = 0; $i -lt $displayCount; $i++) { Draw-Row ($topIndex + $i) $topIndex (($topIndex + $i) -eq $index) }
        Draw-Footer
    } elseif ($index -ne $oldIndex) { Draw-Row $oldIndex $topIndex $false; Draw-Row $index $topIndex $true }
}

[Console]::CursorVisible = $true
Clear-Host
[Console]::SetCursorPosition(0, 0)

# --- CLEAN EXECUTION PHASE ---
$selectedApps = @($menuItems | Where-Object { $_.Selected -and $_.ID -ne "SCRIPT_TITUS" })
$runTitusScript = ($menuItems | Where-Object { $_.ID -eq "SCRIPT_TITUS" }).Selected

if ($selectedApps.Count -gt 0) {
    Write-Host "Updating Winget sources..." -ForegroundColor Cyan
    winget source update | Out-Null
    foreach ($app in $selectedApps) {
        Write-Host "`n==> Processing $($app.Name)..." -ForegroundColor Cyan
        winget install --id $app.ID --exact --silent --accept-source-agreements --accept-package-agreements
    }
}

if ($runTitusScript) {
    Write-Host "`n==> Launching Chris Titus Tech Utility..." -ForegroundColor Magenta
    irm christitus.com/win | iex
}

Write-Host "`nExecution complete! A system reboot is highly recommended." -ForegroundColor Green