# v13t2026@gmail.com
# Tiny tool to open Firefox and Google Chrome for crypto
# v13t2026@gmail.com
#
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#https://www.guru99.com/powershell-tutorial.html

#Usage: Open Command Prompt cmd.exe from Windows + R then issue the command
#powershell -File d:\coin.ps1
#pwsh -File d:\coin.ps1

Write-Host "Welcome to CoinMining script"
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#Get-ExecutionPolicy -Scope CurrentUser
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Windows shortcut target
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "& C:\coin.ps1" -NoLogo -NonInteractive -NoProfile

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

function Check-And-Open-HerondBrowser
{
    $urls = @("https://app.nodepay.ai/dashboard")
    #$nodepaytab = "https://app.nodepay.ai/dashboard"

    # Path to Herond executable 
    $herondPath = "C:\Program Files\HerondLabs\Herond-Browser\Application\Herond.exe"

    # Check if Herond executable exists
    if (Test-Path $herondPath)
    {
        Write-Host "Herond Browser found at: $herondPath" -ForegroundColor Green
        # Open the first URL normally to start the Herond process
        Start-Process -FilePath $herondPath -ArgumentList $urls[0]
        Start-Sleep -Seconds $delay

        # Open remaining URLs in new tabs
        foreach ($url in $urls[1..($urls.Count - 1)])
        {
            Start-Process -FilePath $herondPath -ArgumentList "--new-tab", $url  -Wait
            Start-Sleep -Seconds $delay
        }
    }
    else
    {
        Write-Host "Herond Browser is not installed on this system." -ForegroundColor Red
    }
    return "Function exited."
}

#
# G O O G L E  C H R O M E
#

# Array of URLs to open
$urls = @("https://x.com/home",
           "https://discord.com/channels/@me",
           "https://app.getgrass.io/dashboard",
#           "https://task.testnet.mangonetwork.io/events",
           "https://app.gradient.network/dashboard",
           "https://app.blockmesh.xyz/ui/dashboard",
           "https://bless.network/dashboard",
           "https://airdrop.krain.ai/dashboard",
           "https://access.redbelly.network/",
           "https://redbelly.faucetme.pro/",
           "https://app.meshchain.ai/nodes",
           "https://zero.kaisar.io/missions",
           "https://unich.com/en/airdrop",
           "https://openloop.so/dashboard",
           "https://dataquest.nvg8.io/dashboard",
#           "https://genesis.chainbase.com/",
           "https://dashboard.teneo.pro/dashboard",
#           "https://xbnb.app/dashboard",
           "https://faucetpay.io/page/user-admin/overview",
           "https://www.coinpayu.com/dashboard",
           "https://app.ogcom.xyz/",
           "https://alphaos.net/point",
           "https://adbtc.top/",
           "https://freebitco.in/",
           "https://freeton.in/?op=home",
           "https://dogefree.in/?op=home",
           "https://freesol.in/?op=home",
           "https://sparkchain.ai/dashboard",
           "https://earn.taker.xyz/",
           "https://dashboard.layeredge.io/",
           "https://x.ink/airdrop",
           "https://www.sosovalue.com/exp",
           "https://web.telegram.org"
)

# Path to Chrome executable (adjust the path if Chrome is installed elsewhere)
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Check if Chrome executable exists
if (Test-Path $chromePath)
{
    # Open the first URL normally to start the Chrome process
    Start-Process -FilePath $chromePath -ArgumentList $urls[0]
    Start-Sleep -Seconds $delay

    # Open remaining URLs in new tabs
    foreach ($url in $urls[1..($urls.Count - 1)])
    {
        Start-Process -FilePath $chromePath -ArgumentList "--new-tab", $url  -Wait
        Start-Sleep -Seconds $delay
    }
}
else
{
    Write-Host "Chrome executable not found at $chromePath. Please check the path."
}


#
# M O Z I L L A  F I R E F O X
#
$ftabs = @("https://www.notion.so/bitcoin-13b097956ffc482599323bf099454b08",
           "https://vnexpress.net/",
           "https://www.flickr.com/"
)
foreach($tab in $ftabs)
{
    [system.Diagnostics.Process]::Start("firefox", $tab)
    Start-Sleep -Seconds $delay
}

# Windows Start Command
# Since we can use Windows Command Prompt on PowerShell, we can also use its command like start. 
# This command can only be run in Windows.
$etabs = @("https://chatgpt.com/",
           "https://rewards.bing.com/",
           "https://www.perplexity.ai/"
)
foreach($tab in $etabs)
{
    Start-Process msedge.exe $tab -Wait
    Start-Sleep -Seconds $delay
}

# Call HerondBrowser
$result = Check-And-Open-HerondBrowser
Write-Host "Function result: $result"

Write-Host "Quick! Check this before session closes!!"
Start-Sleep -Seconds $delay
Exit