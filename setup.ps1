$entertainmentSoftware = "vlc", "spotify"
$developmentSoftware = "jetbrainstoolbox", "camunda-modeler", "unity", "git", "maven", "openjdk", "python3", "blender", "docker-cli", "docker-desktop"
$communicationsSoftware = "discord", "teamspeak"
$gamingSoftware = "steam-client", "epicgameslauncher", "origin"
$tools = "atom", "1password", "nvidia-display-driver", "7zip", "teamviewer", "cloudstation", "openvpn", "etcher", "obs-studio", "handbrake", "virtualbox"
$browser = "googlechrome"

$SophiaUrl = "https://github.com/farag2/Windows-10-Sophia-Script/releases/download/5.10.8/Sophia.Script.v5.10.8.zip"
$SophiaHash = '6716E08E06B509AC3AD3F07FB6A3368318D6F6922F1BC817F41CEA6A8AB259A1'
$SophiaInstallPath = "C:\temp"
$SophiaUrlCustomized = "https://raw.githubusercontent.com/Cuupa/windows-setup/main/Sophia.ps1"

Start

function Start() {
  Clear-Host
  Set-ExecutionPolicy RemoteSigned
  Install-Updates
  Install-Sophia
  Customize-Sophia
  Call-Sophia
  Install-Chocolatey
  Install-Choco-Packages
  End-Install
}

function Log-Error($message) {
  Write-Host -ForegroundColor Red $message
  End-Install
}

function Install-Updates() {
  Install-Module -Name PSWindowsUpdate -confirm:$false
  Import-Module PSWindowsUpdate
  Get-WindowsUpdate -Install -AcceptAll
}

function End-Install() {
  Set-ExecutionPolicy Restricted
  pause
  exit
}

function Install-Sophia() {
  New-Item -Path $SophiaInstallPath -ItemType "directory" -Force
  $PathToDownload = $SophiaInstallPath + "\sophia.zip"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrl, $PathToDownload)
  $FileHash = Get-FileHash $PathToDownload

  if($FileHash.Hash -ne $SophiaHash) {
    Remove-Item $PathToDownload
    Log-Error("Filehash not matching")
  }

  Expand-Archive $PathToDownload -DestinationPath $SophiaInstallPath
}

function Customize-Sophia() {
  $PathToDownload = $SophiaInstallPath + "\Sophia Script v5.10.8\Sophia.ps1"
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile($SophiaUrlCustomized, $PathToDownload)
}

function Call-Sophia() {
  Invoke-Expression -Command "& 'C:\temp\Sophia Script v5.10.8\Sophia.ps1'"
}

function Install-Chocolatey() {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Install-Choco-Packages() {
  choco install $entertainmentSoftware -y
  choco install $developmentSoftware -y
  choco install $communicationsSoftware -y
  choco install $gamingSoftware -y
  choco install $tools -y
  choco install $browser -y
}
