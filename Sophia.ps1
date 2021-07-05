#Requires -RunAsAdministrator
#Requires -Version 5.1

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string[]]
	$Functions
)

Clear-Host

$Host.UI.RawUI.WindowTitle = "Windows 10 Sophia Script v5.10.8 | Made with $([char]::ConvertFromUtf32(0x1F497)) of Windows 10 | $([char]0x00A9) farag & Inestic, 2014–2021"

Remove-Module -Name Sophia -Force -ErrorAction Ignore
Import-Module -Name $PSScriptRoot\Manifest\Sophia.psd1 -PassThru -Force

Import-LocalizedData -BindingVariable Global:Localization -FileName Sophia -BaseDirectory $PSScriptRoot\Localizations


if ($Functions)
{
	Invoke-Command -ScriptBlock {Checkings}

	foreach ($Function in $Functions)
	{
		Invoke-Expression -Command $Function
	}

	Invoke-Command -ScriptBlock {RefreshEnvironment; Errors}

	exit
}

#region Protection
<#
	The necessary checkings. If you want to disable a warning message about whether the preset file was customized, remove the "-Warning" argument
	Please, do not comment out this function
#>
Checkings -Warning

<#
	Enable script logging. Log will be recorded into the script folder
	To stop logging just close console or type "Stop-Transcript"
#>
# Logging

# Create a restore point
CreateRestorePoint
#endregion Protection

#region Privacy & Telemetry
# Disable the DiagTrack service, and block connection for the Unified Telemetry Client Outbound Traffic
DiagTrackService -Disable

# Enable the DiagTrack service, and allow connection for the Unified Telemetry Client Outbound Traffic
# DiagTrackService -Enable

# Set the OS level of diagnostic data gathering to minimum
DiagnosticDataLevel -Minimal

# Set the default OS level of diagnostic data gathering
# DiagnosticDataLevel -Default

# Turn off the Windows Error Reporting
ErrorReporting -Disable

# Turn on the Windows Error Reporting (default value)
# ErrorReporting -Enable

# Change the Windows feedback frequency to "Never"
WindowsFeedback -Disable

# Change the Windows Feedback frequency to "Automatically" (default value)
# WindowsFeedback -Enable

# Turn off the diagnostics tracking scheduled tasks
ScheduledTasks -Disable

# Turn on the diagnostics tracking scheduled tasks (default value)
# ScheduledTasks -Enable

# Do not use sign-in info to automatically finish setting up device and reopen apps after an update or restart
#SigninInfo -Disable

# Use sign-in info to automatically finish setting up device and reopen apps after an update or restart (default value)
# SigninInfo -Enable

# Do not let websites provide locally relevant content by accessing language list
LanguageListAccess -Disable

# Let websites provide locally relevant content by accessing language list (default value)
# LanguageListAccess -Enable

# Do not allow apps to use advertising ID
AdvertisingID -Disable

# Allow apps to use advertising ID (default value)
# AdvertisingID -Enable

# Do not let apps on other devices open and message apps on this device, and vice versa
ShareAcrossDevices -Disable

# Let apps on other devices open and message apps on this device, and vice versa (default value)
# ShareAcrossDevices -Enable

# Hide the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested
WindowsWelcomeExperience -Hide

# Show the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested (default value)
# WindowsWelcomeExperience -Show

# Get tip, trick, and suggestions as you use Windows (default value)
#WindowsTips -Enable

# Do not get tip, trick, and suggestions as you use Windows
WindowsTips -Disable

# Hide the suggested content in the Settings app
SettingsSuggestedContent -Hide

# Show the suggested content in the Settings app (default value)
# SettingsSuggestedContent -Show

# Turn off the automatic installing suggested apps
AppsSilentInstalling -Disable

# Turn on automatic installing suggested apps (default value)
# AppsSilentInstalling -Enable

# Do not suggest ways I can finish setting up my device to get the most out of Windows
WhatsNewInWindows -Disable

# Suggest ways I can finish setting up my device to get the most out of Windows (default value)
# WhatsNewInWindows -Enable

# Do not offer tailored experiences based on the diagnostic data setting
TailoredExperiences -Disable

# Offer tailored experiences based on the diagnostic data setting (default value)
# TailoredExperiences -Enable

# Disable Bing search in the Start Menu (for the USA only)
BingSearch -Disable

# Enable Bing search in the Start Menu (default value)
# BingSearch -Enable
#endregion Privacy & Telemetry

#region UI & Personalization
# Show the "This PC" icon on Desktop
#ThisPC -Show

# Hide the "This PC" icon on Desktop (default value)
# Скрывать "Этот компьютер" на рабочем столе (значение по умолчанию)
# ThisPC -Hide

# Do not use check boxes to select items
#CheckBoxes -Disable

# Use check boxes to select items (default value)
CheckBoxes -Enable

# Show hidden files, folders, and drives
HiddenItems -Enable

# Do not show hidden files, folders, and drives (default value)
# HiddenItems -Disable

# Show file name extensions
FileExtensions -Show

# Hide file name extensions (default value)
# FileExtensions -Hide

# Do not hide folder merge conflicts
MergeConflicts -Show

# Hide folder merge conflicts (default value)
# MergeConflicts -Hide

# Open File Explorer to: "This PC"
OpenFileExplorerTo -ThisPC

# Open File Explorer to: Quick access (default value)
# OpenFileExplorerTo -QuickAccess

# Hide Cortana button on the taskbar
CortanaButton -Hide

# Show Cortana button on the taskbar (default value)
# CortanaButton -Show

# Do not show sync provider notification within File Explorer
OneDriveFileExplorerAd -Hide

# Show sync provider notification within File Explorer (default value)
# OneDriveFileExplorerAd -Show

# When I snap a window, do not show what I can snap next to it
#SnapAssist -Disable

# When I snap a window, show what I can snap next to it (default value)
SnapAssist -Enable

# Show the file transfer dialog box in the detailed mode
FileTransferDialog -Detailed

# Show the file transfer dialog box in the compact mode (default value)
# FileTransferDialog -Compact

# Expand the File Explorer ribbon
FileExplorerRibbon -Expanded

# Minimize the File Explorer ribbon (default value)
# FileExplorerRibbon -Minimized

# Display the recycle bin files delete confirmation dialog
RecycleBinDeleteConfirmation -Enable

# Do not display the recycle bin files delete confirmation dialog (default value)
# RecycleBinDeleteConfirmation -Disable

# Hide the "3D Objects" folder in "This PC" and Quick access
3DObjects -Hide

# Show the "3D Objects" folder in "This PC" and Quick access (default value)
# 3DObjects -Show

# Hide frequently used folders in Quick access
#QuickAccessFrequentFolders -Hide

# Show frequently used folders in Quick access (default value)
QuickAccessFrequentFolders -Show

# Do not show recently used files in Quick access
#QuickAccessRecentFiles -Hide

# Show recently used files in Quick access (default value)
QuickAccessRecentFiles -Show

# Hide Task View button on the taskbar
#TaskViewButton -Hide

# Show Task View button on the taskbar (default value)
TaskViewButton -Show

# Hide People button on the taskbar
PeopleTaskbar -Hide

# Show People button on the taskbar (default value)
# PeopleTaskbar -Show

# Show seconds on the taskbar clock
SecondsInSystemClock -Show

# Hide seconds on the taskbar clock (default value)
# SecondsInSystemClock -Hide

# Hide the search on the taskbar
TaskbarSearch -Hide

# Show the search icon on the taskbar
# TaskbarSearch -SearchIcon

# Show the search box on the taskbar (default value)
# TaskbarSearch -SearchBox

# Do not show the Windows Ink Workspace button on the taskbar
WindowsInkWorkspace -Hide

# Show Windows Ink Workspace button on the taskbar (default value)
# WindowsInkWorkspace -Show

# Always show all icons in the notification area
# TrayIcons -Show

# Do not show all icons in the notification area (default value)
TrayIcons -Hide

# Hide the Meet Now icon in the notification area
MeetNow -Hide

# Show the Meet Now icon in the notification area
# MeetNow -Show

# Hide "News and Interests" on the taskbar
NewsInterests -Hide

# Show "News and Interests" on the taskbar (default value)
# NewsInterests -Show

# Unpin the "Microsoft Edge", "Microsoft Store", or "Mail" shortcuts from the taskbar
UnpinTaskbarShortcuts -Shortcuts Edge, Store, Mail

# View the Control Panel icons by: large icons
ControlPanelView -LargeIcons

# View the Control Panel icons by: small icons
# ControlPanelView -SmallIcons

# View the Control Panel icons by: category (default value)
# ControlPanelView -Category

# Set the Windows mode color scheme to the dark
# WindowsColorScheme -Dark

# Set the Windows mode color scheme to the light
# Установить режим цвета для Windows на светлый
WindowsColorScheme -Light

# Set the app mode color scheme to the dark
AppMode -Dark

# Set the app mode color scheme to the light
# AppMode -Light

# Do not show the "New App Installed" indicator
# NewAppInstalledNotification -Hide

# Show the "New App Installed" indicator (default value)
NewAppInstalledNotification -Show

# Hide first sign-in animation after the upgrade
FirstLogonAnimation -Disable

# Show first sign-in animation after the upgrade (default value)
# FirstLogonAnimation -Enable

# Set the quality factor of the JPEG desktop wallpapers to maximum
JPEGWallpapersQuality -Max

# Set the quality factor of the JPEG desktop wallpapers to default
# JPEGWallpapersQuality -Default

# Start Task Manager in expanded mode
TaskManagerWindow -Expanded

# Start Task Manager in compact mode (default value)
# TaskManagerWindow -Compact

# Show a notification when your PC requires a restart to finish updating
RestartNotification -Show

# Do not show a notification when your PC requires a restart to finish updating (default value)
# RestartNotification -Hide

# Do not add the "- Shortcut" suffix to the file name of created shortcuts
ShortcutsSuffix -Disable

# Add the "- Shortcut" suffix to the file name of created shortcuts (default value)
# ShortcutsSuffix -Enable

# Use the PrtScn button to open screen snipping
PrtScnSnippingTool -Enable

# Do not use the PrtScn button to open screen snipping (default value)
# PrtScnSnippingTool -Disable

# Let me use a different input method for each app window
AppsLanguageSwitch -Enable

# Do not let use a different input method for each app window (default value)
# Не позволять выбирать метод ввода для каждого окна (значение по умолчанию)
# AppsLanguageSwitch -Disable
#endregion UI & Personalization

#region OneDrive
# Uninstall OneDrive. The OneDrive user folder won't be removed
# OneDrive -Uninstall

# Install OneDrive (default value)
# OneDrive -Install
#endregion OneDrive

#region System
#region StorageSense
# Turn on Storage Sense
StorageSense -Enable

# Turn off Storage Sense (default value)
# StorageSense -Disable

# Run Storage Sense every month
StorageSenseFrequency -Month

# Run Storage Sense during low free disk space (default value)
# StorageSenseFrequency -Default

# Delete temporary files that apps aren't using
StorageSenseTempFiles -Enable

# Do not delete temporary files that apps aren't using
# StorageSenseTempFiles -Disable

# Delete files in recycle bin if they have been there for over 30 days
StorageSenseRecycleBin -Enable

# Do not delete files in recycle bin if they have been there for over 30 days
# StorageSenseRecycleBin -Disable
#endregion StorageSense

# Disable hibernation
Hibernate -Disable

# Enable hibernate (default value)
# Hibernate -Enable

# Change the %TEMP% environment variable path to "%SystemDrive%\Temp"
# TempFolder -SystemDrive

# Change %TEMP% environment variable path to "%LOCALAPPDATA%\Temp" (default value)
TempFolder -Default

# Disable the Windows 260 characters path limit
Win32LongPathLimit -Disable

# Enable the Windows 260 character path limit (default value)
# Win32LongPathLimit -Enable

# Display the Stop error information on the BSoD
BSoDStopError -Enable

# Do not display the Stop error information on the BSoD (default value)
# Не отображать Stop-ошибку при появлении BSoD (значение по умолчанию)
# BSoDStopError -Disable

# Choose when to be notified about changes to your computer: never notify
# AdminApprovalMode -Disable

# Choose when to be notified about changes to your computer: notify me only when apps try to make changes to my computer (default value)
AdminApprovalMode -Enable

# Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled
MappedDrivesAppElevatedAccess -Enable

# Turn off access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled (default value)
# MappedDrivesAppElevatedAccess -Disable

# Turn off Delivery Optimization
DeliveryOptimization -Disable

# Turn on Delivery Optimization (default value)
# DeliveryOptimization -Enable

# Always wait for the network at computer startup and logon for workgroup networks
# WaitNetworkStartup -Enable

# Never wait for the network at computer startup and logon for workgroup networks (default value)
WaitNetworkStartup -Disable

# Do not let Windows decide which printer should be the default one
# WindowsManageDefaultPrinter -Disable

# Let Windows decide which printer should be the default one (default value)
WindowsManageDefaultPrinter -Enable

<#
	Disable the Windows features using the pop-up dialog box

	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not disable the "MediaPlayback" feature
#>
# WindowsFeatures -Disable

# Enable the Windows features using the pop-up dialog box
# WindowsFeatures -Enable

<#
	Uninstall optional features using the pop-up dialog box
	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not uninstall the "MediaPlayback" feature
#>
#WindowsCapabilities -Uninstall

# Install optional features using the pop-up dialog box
# Установить дополнительные компоненты, используя всплывающее диалоговое окно
# WindowsCapabilities -Install

# Receive updates for other Microsoft products when you update Windows
UpdateMicrosoftProducts -Enable

# Do not receive updates for other Microsoft products when you update Windows (default value)
# UpdateMicrosoftProducts -Disable

<#
	Set the power plan on "High performance"
	It isn't recommended to turn on the "High performance" power plan on laptops
#>
PowerPlan -High

# Set the power plan on "Balanced" (default value)
# PowerPlan -Balanced

# Use latest installed .NET runtime for all apps
LatestInstalled.NET -Enable

# Do not use latest installed .NET runtime for all apps (default value)
# LatestInstalled.NET -Disable

# Do not allow the computer to turn off the network adapters to save power
PCTurnOffDevice -Disable

# Allow the computer to turn off the network adapters to save power (default value)
# PCTurnOffDevice -Enable

# Override for default input method: English
# SetInputMethod -English

# Override for default input method: use language list (default value)
# SetInputMethod -Default

<#
	Move user folders location to the root of any drive using the interactive menu
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %SystemDrive%\Users\%Username% folder by default
#>
# SetUserShellFolderLocation -Root

<#
	Select folders for user folders location manually using a folder browser dialog
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %SystemDrive%\Users\%Username% folder by default
#>
# SetUserShellFolderLocation -Custom

<#
	Change user folders location to the default values
	User files or folders won't me moved to the new location. Move them manually
	They're located in the %SystemDrive%\Users\%Username% folder by default
#>
# SetUserShellFolderLocation -Default

# Save screenshots by pressing Win+PrtScr on the Desktop
WinPrtScrFolder -Desktop

# Save screenshots by pressing Win+PrtScr on the Pictures folder (default value)
# WinPrtScrFolder -Default

<#
	Run troubleshooters automatically, then notify
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data", and the error reporting feature will be turned on
#>
# RecommendedTroubleshooting -Automatic

<#
	Ask me before running troubleshooters (default value)
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data"

	Спрашивать перед запуском средств устранения неполадок (значение по умолчанию)
	Чтобы заработала данная функция, уровень сбора диагностических сведений ОС будет установлен на "Необязательные диагностические данные" и включится создание отчетов об ошибках Windows
#>
# RecommendedTroubleshooting -Default

# Launch folder windows in a separate process
FoldersLaunchSeparateProcess -Enable

# Do not launch folder windows in a separate process (default value)
# FoldersLaunchSeparateProcess -Disable

# Disable and delete reserved storage after the next update installation
# ReservedStorage -Disable

# Enable reserved storage (default value)
# Включить зарезервированное хранилище (значение по умолчанию)
# ReservedStorage -Enable

# Disable help look up via F1
F1HelpPage -Disable

# Enable help look up via F1 (default value)
# F1HelpPage -Enable

# Enable Num Lock at startup
NumLock -Enable

# Disable Num Lock at startup (default value)
# NumLock -Disable

# Enable Caps Lock
# CapsLock -Enable

# Disable Caps Lock (default value)
# CapsLock -Disable

# Disable StickyKey after tapping the Shift key 5 times
StickyShift -Disable

# Enable StickyKey after tapping the Shift key 5 times (default value)
# StickyShift -Enable

# Disable AutoPlay for all media and devices
Autoplay -Disable

# Enable AutoPlay for all media and devices (default value)
# Autoplay -Enable

# Disable thumbnail cache removal
ThumbnailCacheRemoval -Disable

# Enable thumbnail cache removal (default value)
# ThumbnailCacheRemoval -Enable

# Enable automatically saving my restartable apps when signing out and restart them after signing in
SaveRestartableApps -Enable

# Disable automatically saving my restartable apps when signing out and restart them after signing in (default value)
# SaveRestartableApps -Disable

# Enable "Network Discovery" and "File and Printers Sharing" for workgroup networks
NetworkDiscovery -Enable

# Disable "Network Discovery" and "File and Printers Sharing" for workgroup networks (default value)
# NetworkDiscovery -Disable

# Automatically adjust active hours for me based on daily usage
SmartActiveHours -Enable

# Do not automatically adjust active hours for me based on daily usage (default value)
# SmartActiveHours -Disable

# Restart this device as soon as possible when a restart is required to install an update
# DeviceRestartAfterUpdate -Enable

# Do not restart this device as soon as possible when a restart is required to install an update (default value)
# DeviceRestartAfterUpdate -Disable

<#
	Register app, calculate hash, and set as default for specific extension without the "How do you want to open this?" pop-up
	Зарегистрировать приложение, вычислить хэш и установить как приложение по умолчанию для конкретного расширения без всплывающего окна "Каким образом вы хотите открыть этот файл?"

	Set-Association -ProgramPath "C:\SumatraPDF.exe" -Extension .pdf -Icon "shell32.dll,100"
	Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"
#>
# Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"
#endregion System

#region WSL
# Install the Windows Subsystem for Linux (WSL)
WSL -Enable

# Uninstall the Windows Subsystem for Linux (WSL)
# WSL -Disable

<#
	Download and install the Linux kernel update package
	Set WSL 2 as the default version when installing a new Linux distribution
	Run the function only after WSL installed and PC restart
#>
EnableWSL2
#endregion WSL

#region Start menu
# Hide recently added apps in the Start menu
RecentlyAddedApps -Hide

# Show recently added apps in the Start menu (default value)
# RecentlyAddedApps -Show

# Hide app suggestions in the Start menu
AppSuggestions -Hide

# Show app suggestions in the Start menu (default value)
# AppSuggestions -Show

# Run the Windows PowerShell shortcut from the Start menu as Administrator
# RunPowerShellShortcut -Elevated

# Run the Windows PowerShell shortcut from the Start menu as user (default value)
# RunPowerShellShortcut -NonElevated

<#
	Pin to Start the following shortcuts: Control Panel, Devices and Printers, PowerShell
	Valid shortcuts values: ControlPanel, DevicesPrinters and PowerShell
#>
# PinToStart -Tiles ControlPanel, DevicesPrinters, PowerShell

# Unpin all tiles first and pin necessary ones
# PinToStart -UnpinAll -Tiles ControlPanel, DevicesPrinters, PowerShell

# Unpin all the Start tiles
# PinToStart -UnpinAll
#endregion Start menu

#region UWP apps
<#
	Uninstall UWP apps using the pop-up dialog box
	If the "For All Users" is checked apps packages will not be installed for new users
#>
UninstallUWPApps

<#
	Uninstall UWP apps using the pop-up dialog box
	If the "For All Users" is checked apps packages will not be installed for new users
	The "For All Users" checkbox checked by default
#>
# UninstallUWPApps -ForAllUsers

<#
	Restore the default UWP apps using the pop-up dialog box
	UWP apps can be restored only if they were uninstalled only for the current user
#>
# RestoreUWPApps

<#
	Open Microsoft Store "HEVC Video Extensions from Device Manufacturer" page to install this extension manually to be able to open .heic and .heif formats
	The extension can be installed without Microsoft account
#>
# HEIF -Manual

# Download and install "HEVC Video Extensions from Device Manufacturer" to be able to open .heic and .heif formats
HEIF -Install

# Disable Cortana autostarting
CortanaAutostart -Disable

# Enable Cortana autostarting (default value)
# CortanaAutostart -Enable

# Do not let UWP apps run in the background
# BackgroundUWPApps -Disable

# Let all UWP apps run in the background (default value)
BackgroundUWPApps -Enable

# Check for UWP apps updates
CheckUWPAppsUpdates
#endregion UWP apps

#region Gaming
# Disable Xbox Game Bar
XboxGameBar -Disable

# Enable Xbox Game Bar (default value)
# XboxGameBar -Enable

# Disable Xbox Game Bar tips
XboxGameTips -Disable

# Enable Xbox Game Bar tips (default value)
# XboxGameTips -Enable

<#
	Set "High performance" in graphics performance preference for an app
	Only with a dedicated GPU
#>
SetAppGraphicsPerformance

<#
	Turn on hardware-accelerated GPU scheduling. Restart needed
	Only with a dedicated GPU and WDDM verion is 2.7 or higher
#>
GPUScheduling -Enable

# Turn off hardware-accelerated GPU scheduling (default value). Restart needed
# GPUScheduling -Disable
#endregion Gaming

#region Scheduled tasks
<#
	Create the "Windows Cleanup" scheduled task for cleaning up Windows unused files and updates
	A native interactive toast notification pops up every 30 days
	The task runs every 30 days
#>
# CleanupTask -Register

# Delete the "Windows Cleanup" and "Windows Cleanup Notification" scheduled tasks for cleaning up Windows unused files and updates
# CleanupTask -Delete

<#
	Create the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
	The task will wait until the Windows Updates service finishes running
	The task runs every 90 days
#>
# SoftwareDistributionTask -Register

# Delete the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
# SoftwareDistributionTask -Delete

<#
	Create the "Temp" scheduled task for cleaning up the %TEMP% folder
	The task runs every 60 days
#>
TempTask -Register

# Delete the "Temp" scheduled task for cleaning up the %TEMP% folder
# TempTask -Delete
#endregion Scheduled tasks

#region Microsoft Defender & Security
# Enable Controlled folder access and add protected folders
AddProtectedFolders

# Remove all added protected folders
# RemoveProtectedFolders

# Allow an app through Controlled folder access
AddAppControlledFolder

# Remove all allowed apps through Controlled folder access
# RemoveAllowedAppsControlledFolder

# Add a folder to the exclusion from Microsoft Defender scanning
# AddDefenderExclusionFolder

# Remove all excluded folders from Microsoft Defender scanning
# RemoveDefenderExclusionFolders

# Add a file to the exclusion from Microsoft Defender scanning
AddDefenderExclusionFile

# Remove all excluded files from Microsoft Defender scanning
# RemoveDefenderExclusionFiles

# Enable Microsoft Defender Exploit Guard network protection
NetworkProtection -Enable

# Disable Microsoft Defender Exploit Guard network protection (default value)
# NetworkProtection -Disable

# Enable detection for potentially unwanted applications and block them
PUAppsDetection -Enable

# Disable detection for potentially unwanted applications and block them (default value)
# PUAppsDetection -Disable

<#
	Enable sandboxing for Microsoft Defender
	There is a bug in KVM with QEMU: enabling this function causes VM to freeze up during the loading phase of Windows
#>
DefenderSandbox -Enable

# Disable sandboxing for Microsoft Defender (default value)
# DefenderSandbox -Disable

# Dismiss Microsoft Defender offer in the Windows Security about signing in Microsoft account
DismissMSAccount

# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
DismissSmartScreenFilter

# Enable events auditing generated when a process is created or starts
# AuditProcess -Enable

# Disable events auditing generated when a process is created or starts (default value)
# AuditProcess -Disable

<#
	Include command line in process creation events
	In order this feature to work events auditing will be enabled ("AuditProcess -Enable" function)
#>
# AuditCommandLineProcess -Enable

# Do not include command line in process creation events (default value)
# AuditCommandLineProcess -Disable

<#
	Create "Process Creation" Event Viewer Custom View
	In order this feature to work events auditing ("AuditProcess -Enable" function) and command line in process creation events will be enabled
#>
EventViewerCustomView -Enable

# Remove "Process Creation" Event Viewer Custom View (default value)
# EventViewerCustomView -Disable

# Enable logging for all Windows PowerShell modules
PowerShellModulesLogging -Enable

# Disable logging for all Windows PowerShell modules (default value)
# PowerShellModulesLogging -Disable

# Enable logging for all PowerShell scripts input to the Windows PowerShell event log
PowerShellScriptsLogging -Enable

# Disable logging for all PowerShell scripts input to the Windows PowerShell event log (default value)
# PowerShellScriptsLogging -Disable

# Disable apps and files checking within Microsofot Defender SmartScreen
# AppsSmartScreen -Disable

# Enable apps and files checking within Microsofot Defender SmartScree (default value)
AppsSmartScreen -Enable

# Disable the Attachment Manager marking files that have been downloaded from the Internet as unsafe
# SaveZoneInformation -Disable

# Enable the Attachment Manager marking files that have been downloaded from the Internet as unsafe (default value)
# SaveZoneInformation -Enable

<#
	Disable Windows Script Host
	Blocks WSH from executing .js and .vbs files
#>
WindowsScriptHost -Disable

# Enable Windows Script Host (default value)
# WindowsScriptHost -Enable

# Enable Windows Sandbox
WindowsSandbox -Enable

# Disable Windows Sandbox (default value)
# WindowsSandbox -Disable
#endregion Microsoft Defender & Security

#region Context menu
# Add the "Extract all" item to Windows Installer (.msi) context menu
MSIExtractContext -Add

# Remove the "Extract all" item from Windows Installer (.msi) context menu (default value)
# MSIExtractContext -Remove

<#
	Add the "Install" item to the .cab archives context menu
	If the .cab file extension type associated to open with a third party app by default, the "Install" context menu item won't be displayed,
	so the default association for the .cab file type will be restored forcedly
#>
# CABInstallContext -Add

# Remove the "Install" item from the .cab archives context menu (default value)
# CABInstallContext -Remove

# Add the "Run as different user" item to the .exe files types context menu
RunAsDifferentUserContext -Add

# Remove the "Run as different user" item from the .exe files types context menu (default value)
# RunAsDifferentUserContext -Remove

# Hide the "Cast to Device" item from the context menu
# CastToDeviceContext -Hide

# Show the "Cast to Device" item in the context menu (default value)
CastToDeviceContext -Show

# Hide the "Share" item from the context menu
ShareContext -Hide

# Show the "Share" item in the context menu (default value)
# ShareContext -Show

# Hide the "Edit with Paint 3D" item from the context menu
EditWithPaint3DContext -Hide

# Show the "Edit with Paint 3D" item in the context menu (default value)
# EditWithPaint3DContext -Show

# Hide the "Edit with Photos" item from the context menu
# EditWithPhotosContext -Hide

# Show the "Edit with Photos" item in the context menu (default value)
EditWithPhotosContext -Show

# Hide the "Create a new video" item from the context menu
CreateANewVideoContext -Hide

# Show the "Create a new video" item in the context menu (default value)
# CreateANewVideoContext -Show

# Hide the "Edit" item from the images context menu
# ImagesEditContext -Hide

# Show the "Edit" item from in images context menu (default value)
ImagesEditContext -Show

# Hide the "Print" item from the .bat and .cmd context menu
PrintCMDContext -Hide

# Show the "Print" item in the .bat and .cmd context menu (default value)
# PrintCMDContext -Show

# Hide the "Include in Library" item from the context menu
IncludeInLibraryContext -Hide

# Show the "Include in Library" item in the context menu (default value)
# IncludeInLibraryContext -Show

# Hide the "Send to" item from the folders context menu
SendToContext -Hide

# Show the "Send to" item in the folders context menu (default value)
# SendToContext -Show

# Hide the "Turn on BitLocker" item from the context menu
# BitLockerContext -Hide

# Show the "Turn on BitLocker" item in the context menu (default value)
BitLockerContext -Show

# Remove the "Bitmap image" item from the "New" context menu
# BitmapImageNewContext -Remove

# Add the "Bitmap image" item to the "New" context menu (default value)
# BitmapImageNewContext -Add

# Remove the "Rich Text Document" item from the "New" context menu
RichTextDocumentNewContext -Remove

# Add the "Rich Text Document" item to the "New" context menu (default value)
# RichTextDocumentNewContext -Add

# Remove the "Compressed (zipped) Folder" item from the "New" context menu
# CompressedFolderNewContext -Remove

# Add the "Compressed (zipped) Folder" item to the "New" context menu (default value)
CompressedFolderNewContext -Add

# Enable the "Open", "Print", and "Edit" context menu items for more than 15 items selected
MultipleInvokeContext -Enable

# Disable the "Open", "Print", and "Edit" context menu items for more than 15 items selected (default value)
# MultipleInvokeContext -Disable

# Hide the "Look for an app in the Microsoft Store" item in the "Open with" dialog
UseStoreOpenWith -Hide

# Show the "Look for an app in the Microsoft Store" item in the "Open with" dialog (default value)
# UseStoreOpenWith -Show

# Hide the "Previous Versions" tab from the files and folders context menu and the "Restore previous versions" context menu item
# PreviousVersionsPage -Hide

# Show the "Previous Versions" tab from files and folders context menu and also the "Restore previous versions" context menu item (default value)
PreviousVersionsPage -Show
#endregion Context menu

<#
	Simulate pressing F5 to refresh the desktop
	Refresh desktop icons, environment variables, taskbar
	Restart the Start menu
	Please, do not comment out this function
#>
RefreshEnvironment

<#
	Errors output
	Please, do not comment out this function
#>
Errors
