#
# Tiny tool to open Firefox and Google Chrome for daily
#
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#https://www.guru99.com/powershell-tutorial.html

#Usage: Open Command Prompt cmd.exe from Windows + R then issue the command
#powershell -File d:\tanth.ps1
#pwsh -File d:\tanth.ps1

Write-Host "Welcome to DailyTools script"
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#Get-ExecutionPolicy -Scope CurrentUser
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Windows shortcut target
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "& C:\tanth.ps1" -NoLogo -NonInteractive -NoProfile

$delay = 3

function not-exist { -not (Test-Path $args) }
Set-Alias !exist not-exist -Option "Constant, AllScope"
Set-Alias exist Test-Path -Option "Constant, AllScope"


$isChromeInstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
if ($isChromeInstalled  -eq $null)
{
	Write-Host "Chrome browser not available"
	Start-Sleep -Seconds $delay
	Exit
}


$isFirefoxInstalled = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Mozilla\Mozilla Firefox' -Name "CurrentVersion"
if ($isFirefoxInstalled -eq $null)
{
	Write-Host "Firefox browser not available"
	Start-Sleep -Seconds $delay
	Exit
}


#
# G O O G L E  C H R O M E
#

$flashscore = "https://www.flashscore.com/"
[system.Diagnostics.Process]::Start("chrome", $flashscore)
Start-Sleep -Seconds $delay
# All information about Google sheet
# link=329776956
# https://docs.google.com/spreadsheets/d/1IPFhwhUV4EAR_7MrW-PpnZlvIesAztNsczyTIZLOJks/edit#gid=794276770
# 2024
# https://docs.google.com/spreadsheets/d/1VJZ_GSyEDPYSwbYQoHT0isy0Lbb6nbcsGclIH6qEvuI/edit#gid=794276770
$gdocs = "https://docs.google.com/spreadsheets/d/"
$gsheetlink = "1VJZ_GSyEDPYSwbYQoHT0isy0Lbb6nbcsGclIH6qEvuI/edit#gid="
$pm2 = 794276770
$sheet = $gdocs + $gsheetlink + $pm2
[system.Diagnostics.Process]::Start("chrome", $sheet)
Start-Sleep -Seconds $delay
$fb = "https://www.facebook.com/"
[system.Diagnostics.Process]::Start("chrome", $fb)
Start-Sleep -Seconds $delay

$sjc = "https://sjc.com.vn/"
[system.Diagnostics.Process]::Start("chrome", $sjc)
Start-Sleep -Seconds $delay

# Indexer
# https://docs.google.com/spreadsheets/d/18EEGxYsFxHXMov4P4esRXNIKbVeAgT3ShH6EnMhlKGQ/edit#gid=347839186
$gsheetlink3 = "18EEGxYsFxHXMov4P4esRXNIKbVeAgT3ShH6EnMhlKGQ/edit#gid="
$idx = 347839186
$sheet3 = $gdocs + $gsheetlink3 + $idx
[system.Diagnostics.Process]::Start("chrome", $sheet3)
Start-Sleep -Seconds $delay

# Google News
$gnews = "https://news.google.com/home?hl=vi&gl=VN&ceid=VN%3Avi"
[system.Diagnostics.Process]::Start("chrome", $gnews)
Start-Sleep -Seconds $delay

# GiaVang google sheet
# https://docs.google.com/spreadsheets/d/1KHvuzUhNOFSF8lpIeQFW6nMCsblDtR9Dnfx_oGydPMc/edit#gid=1034585329
# sheet 2024 1053524980
$giaVang = "1KHvuzUhNOFSF8lpIeQFW6nMCsblDtR9Dnfx_oGydPMc/edit#gid="
$idx = 1053524980
$sheet4 = $gdocs + $giaVang + $idx
[system.Diagnostics.Process]::Start("chrome", $sheet4)

# mpJack
# https://replit.com/@hoangviet2105/mpjack
$mpjack = "https://replit.com/@hoangviet2105/mpjack"
[system.Diagnostics.Process]::Start("chrome", $mpjack)
Start-Sleep -Seconds $delay

# https://www.giveawayoftheday.com/
$giveaway = "https://www.giveawayoftheday.com/"
[system.Diagnostics.Process]::Start("chrome", $giveaway)
Start-Sleep -Seconds $delay

$msreward = "https://rewards.bing.com/"
[system.Diagnostics.Process]::Start("chrome", $msreward)
Start-Sleep -Seconds $delay

#
# M O Z I L L A  F I R E F O X
#
$n = "https://www.notion.so/191f69c7da2149c0a5b1ccf1761386af?v=e8a8524b48c4463da2cd3948916e0ce2"
[system.Diagnostics.Process]::Start("firefox", $n)
Start-Sleep -Seconds $delay

$f = "https://www.flickr.com/"
[system.Diagnostics.Process]::Start("firefox", $f)
Start-Sleep -Seconds $delay

$v = "https://vnexpress.net/"
[system.Diagnostics.Process]::Start("firefox", $v)
Start-Sleep -Seconds $delay

# Windows Start Command
# Since we can use Windows Command Prompt on PowerShell, we can also use its command like start. 
# This command can only be run in Windows.
#start microsoft-edge:https://chat.openai.com/
start microsoft-edge:https://chatgpt.com/
start microsoft-edge:https://rewards.bing.com/
start microsoft-edge:https://www.perplexity.ai/



#
# Windows Apps
#
$notepadPlusPlusPath = 'C:\Program Files\Notepad++\notepad++.exe'
# if (exist $path) { Start-Process $notepadPlusPlusPath } 
# Check if the file exists
if (Test-Path $notepadPlusPlusPath)
{
    # Start Notepad++ with administrator permissions
    Start-Process -FilePath $notepadPlusPlusPath -Verb RunAs
    #Write-Output "Notepad++ started with administrator permissions."
}
else
{
    Write-Output "Notepad++.exe not found at the specified path: $notepadPlusPlusPath"
}




$folderPaths = @("C:\Users\ngong\OneDrive\Documents", "C:\Users\ngong\Downloads\ChinhSach", "C:\Users\ngong\Downloads")

# Function to get the list of open explorer windows and their paths
function Get-OpenExplorerWindows
{
    $shell = New-Object -ComObject Shell.Application
    $shell.Windows() | ForEach-Object {
        if ($_.Name -eq "File Explorer")
        {
            $path = $_.document.folder.self.path
            New-Object PSObject -Property @{
                Path = $path
                Window = $_
            }
        }
    }
}

# Get the open explorer windows
$openWindows = Get-OpenExplorerWindows

# Check each folder and open if not already open
foreach ($folderPath in $folderPaths)
{
    $folderIsOpen = $openWindows | Where-Object { $_.Path -eq $folderPath }

    if ($folderIsOpen)
    {
        # Write-Output "The folder '$folderPath' is already open in an existing instance of explorer.exe."
        # Do nothing
    }
    else
    {
        # Open the folder in a new explorer window
        Start-Process explorer.exe $folderPath -WindowStyle Minimized
        #Write-Output "The folder '$folderPath' was not open. A new instance has been started."
    }
}

Write-Host "Quick! Check this before session closes!!"
Start-Sleep -Seconds 5
Exit
