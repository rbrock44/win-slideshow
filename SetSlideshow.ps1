param(
    # Default to directory where this script resides
    [string]$PictureFolder = "$PSScriptRoot/backgrounds"
)

# --- Registry paths ---
$advPath = "HKCU:\Control Panel\Desktop"
$slideshowPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers"
$powerPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers\Slideshow"

# Ensure folder exists
if (!(Test-Path $PictureFolder)) {
    Write-Host "Creating slideshow folder: $PictureFolder"
    New-Item -ItemType Directory -Path $PictureFolder | Out-Null
}

Write-Host "Setting slideshow folder to: $PictureFolder"

# --- Set slideshow folder ---
Set-ItemProperty -Path $slideshowPath -Name "SlideshowDirectoryPath" -Value $PictureFolder

# --- Enable slideshow ---
Set-ItemProperty -Path $slideshowPath -Name "SlideshowEnabled" -Value 1

# --- Slideshow interval ---
# 30 minutes = 1800000 ms
Set-ItemProperty -Path $powerPath -Name "Interval" -Value 1800000

# --- Shuffle ---
Set-ItemProperty -Path $powerPath -Name "Shuffle" -Value 1

# --- Allow slideshow on battery ---
Set-ItemProperty -Path $powerPath -Name "BatteryAware" -Value 0
Set-ItemProperty -Path $powerPath -Name "RunOnBattery" -Value 1

# --- Set wallpaper style: Fill ---
Set-ItemProperty -Path $advPath -Name "WallpaperStyle" -Value 10
Set-ItemProperty -Path $advPath -Name "TileWallpaper" -Value 0

# --- Refresh Explorer wallpaper settings ---
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters

Write-Host "Slideshow settings applied successfully."
