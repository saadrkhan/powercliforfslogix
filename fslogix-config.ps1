# Download and install FSLogix
Invoke-WebRequest -Uri $fileUris[0] -OutFile "C:\Temp\FSLogix.zip"
Expand-Archive -Path "C:\Temp\FSLogix.zip" -DestinationPath "C:\Temp\FSLogix"
Start-Process -FilePath "C:\Temp\FSLogix\x64\Release\FSLogixAppsSetup.exe" -ArgumentList "/install /quiet /norestart" -Wait

# Configure FSLogix registry settings
$regPath = "HKLM:\SOFTWARE\FSLogix\Profiles"
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set FSLogix configuration
Set-ItemProperty -Path $regPath -Name "Enabled" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "VHDLocations" -Value "\\$($env:storageAccountName).file.core.windows.net\$($env:fileShareName)" -Type String
Set-ItemProperty -Path $regPath -Name "DeleteLocalProfileWhenVHDShouldApply" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "FlipFlopProfileDirectoryName" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "IsDynamic" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "VolumeType" -Value "VHDX" -Type String
Set-ItemProperty -Path $regPath -Name "SizeInMBs" -Value 30000 -Type DWord

# Enable Office containers if needed
$officeRegPath = "HKLM:\SOFTWARE\Policies\FSLogix\ODFC"
if (!(Test-Path $officeRegPath)) {
    New-Item -Path $officeRegPath -Force
}
Set-ItemProperty -Path $officeRegPath -Name "Enabled" -Value 1 -Type DWord
Set-ItemProperty -Path $officeRegPath -Name "VHDLocations" -Value "\\$($env:storageAccountName).file.core.windows.net\$($env:fileShareName)" -Type String