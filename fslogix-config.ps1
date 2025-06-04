# Ensure registry path exists
New-Item -Path "HKLM:\SOFTWARE\FSLogix" -Name "Profiles" -Force | Out-Null

# Configure FSLogix
$regPath = "HKLM:\SOFTWARE\FSLogix\Profiles"
$sharePath = "\\${env:STORAGE_ACCOUNT}.file.core.windows.net\${env:SHARE_NAME}"

Set-ItemProperty -Path $regPath -Name "Enabled" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "VHDLocations" -Value $sharePath -Type MultiString
Set-ItemProperty -Path $regPath -Name "DeleteLocalProfileWhenVHDShouldApply" -Value 1 -Type DWord
Set-ItemProperty -Path $regPath -Name "SizeInMBs" -Value 32768 -Type DWord
Set-ItemProperty -Path $regPath -Name "VolumeType" -Value "VHDX" -Type String
