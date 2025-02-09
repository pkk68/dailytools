# 
# Simulation tool to move cursor for relax
# v13t2026@gmail.com
#
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#https://www.guru99.com/powershell-tutorial.html

#Usage: Open Command Prompt cmd.exe from Windows + R then issue the command
#powershell -File d:\MoveCursor.ps1
#pwsh -File d:\MoveCursor.ps1

Write-Host "Welcome to MoveCursor"
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#Get-ExecutionPolicy -Scope CurrentUser
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Windows shortcut target
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "& C:\MoveCursor.ps1" -NoLogo -NonInteractive -NoProfile

$delay = 5
Add-Type -AssemblyName System.Windows.Forms

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class UserInput
{
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
    [DllImport("user32.dll")] 
    public static extern bool GetCursorPos(out POINT lpPoint);
    [DllImport("user32.dll")] 
    public static extern int GetLastInputInfo(ref LASTINPUTINFO plii);
    [StructLayout(LayoutKind.Sequential)]
    public struct POINT {
        public int X;
        public int Y;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO {
        public uint cbSize;
        public int dwTime;
    }
    public static int GetIdleTime() {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)Marshal.SizeOf(typeof(LASTINPUTINFO));
        GetLastInputInfo(ref lii);
        return Environment.TickCount - lii.dwTime;
}
}
"@

function Move-CursorToCenter
{
    $screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
    $screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
    $centerX = [math]::Round($screenWidth / 2)
    $centerY = [math]::Round($screenHeight / 2)
    
    [UserInput]::SetCursorPos($centerX, $centerY)
    Write-Host "Cursor moved to center: ($centerX, $centerY)"
}

function Move-CursorInCircle
{
    param (
        [int]$radius = 150,
        [int]$steps = 360,
        [int]$duration = 1
    )
    
    
    $cursorPos = New-Object UserInput+POINT
    [UserInput]::GetCursorPos([ref]$cursorPos)
   
    $centerX = $cursorPos.X
    $centerY = $cursorPos.Y
    
    for ($i = 0; $i -lt $steps; $i++)
    {
        $angle = 2 * [math]::PI * $i / $steps
        $x = [math]::Round($centerX + $radius * [math]::Cos($angle))
        $y = [math]::Round($centerY + $radius * [math]::Sin($angle))
        [UserInput]::SetCursorPos($x, $y)
        Start-Sleep -Milliseconds ($duration * 1000 / $steps)
    }
}

function Move-CursorInSquare
{
    param (
        [int]$sideLength = 100,
        [int]$duration = 1
    )
    
    #$screenBounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $screenBounds = ([System.Windows.Forms.Screen]::AllScreens |? Primary).Bounds

    $centerX = [math]::Round($screenBounds.Width / 2)
    $centerY = [math]::Round($screenBounds.Height / 2)
    
    [UserInput]::SetCursorPos($centerX, $centerY)
    Start-Sleep -Milliseconds 500
    
    $positions = @(
        @($centerX - $sideLength / 2, $centerY - $sideLength / 2),
        @($centerX + $sideLength / 2, $centerY - $sideLength / 2),
        @($centerX + $sideLength / 2, $centerY + $sideLength / 2),
        @($centerX - $sideLength / 2, $centerY + $sideLength / 2)
    )
  
    foreach ($pos in $positions)
    {
        [UserInput]::SetCursorPos($pos[0], $pos[1])
        Start-Sleep -Milliseconds ($duration * 1000 / 4)
    }
}

function Move-CursorInVShape
{
    param (
        [int]$startX = 300,  # Starting X position
        [int]$startY = 300,  # Starting Y position
        [int]$size = 200,    # Size of the "V" shape
        [int]$delay = 200    # Delay in milliseconds between movements
    )
    
    # Define the three points of the "V" shape
    $leftX = $startX - $size
    $rightX = $startX + $size
    $bottomY = $startY + $size
    
    # Move in "V" char
    [UserInput]::SetCursorPos($leftX, $startY)
    Start-Sleep -Milliseconds $delay
    [UserInput]::SetCursorPos($startX, $bottomY)
    Start-Sleep -Milliseconds $delay
    [UserInput]::SetCursorPos($rightX, $startY)
    Start-Sleep -Milliseconds $delay
}


function Check-Exit
{
    param (
        [char]$exitKey = 'v'
    )
    if ([console]::KeyAvailable)
    {
        $key = [console]::ReadKey($true).KeyChar
        if ($key -eq $exitKey)
        {
            return $true
        }
    }
    return $false
}

function Move-CursorRandomly
{
    param (
        [int]$duration = 10,  # Duration in seconds
        [int]$interval = 1    # Interval between movements in seconds
    )
    
    $screenBounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $screenWidth = $screenBounds.Width
    $screenHeight = $screenBounds.Height
    
    $endTime = (Get-Date).AddSeconds($duration)
    while ((Get-Date) -lt $endTime)
    {
        $randomX = Get-Random -Minimum 0 -Maximum $screenWidth
        $randomY = Get-Random -Minimum 0 -Maximum $screenHeight
        [UserInput]::SetCursorPos($randomX, $randomY)
        Write-Host "Cursor moved to: ($randomX, $randomY)"
        Start-Sleep -Seconds $interval
    }
}

function Get-RandomInteger
{
    param (
        [int]$min = 1,
        [int]$max = 100
    )
    return Get-Random -Minimum $min -Maximum ($max + 1)
}


$running = $true
$functions = {
#    "Move-CursorInCircle" = @(150, 360, 1)
#    "Move-CursorInSquare" = @(200, 1) 
    Move-CursorInCircle
    Move-CursorInSquare
}

$cursorPos = New-Object UserInput+POINT
[UserInput]::GetCursorPos([ref]$cursorPos)

while ($running)
{
    if (Check-Exit)
    {
        Write-Host "Exit key pressed. Stopping script."
        break
    }
    
    $idleTime = [UserInput]::GetIdleTime()
    if ($idleTime -gt 60000)
    { # 1 minute in milliseconds
        switch (Get-RandomInteger -min 1 -max 150)
        {
            {$_ -lt 100} { Move-CursorRandomly; break }
            {$_ -gt 100} { Move-CursorInCircle -radius 150 -steps 360 -duration 1; break }
            {$_  -eq 100}
            {
                Move-CursorInVShape; break 
            }

        }
    }
    Start-Sleep -Seconds $delay
    Move-CursorToCenter
}

