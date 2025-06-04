# Create the base registry key if it doesn't exist
New-Item -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Force -ErrorAction SilentlyContinue | Out-Null

# Core FSLogix settings
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "Enabled" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "VHDLocations" -Type MultiString -Value "\\avdsidfslogixsa123.file.core.windows.net\avd-profiles"
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "DeleteLocalProfileWhenVHDShouldApply" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "SizeInMBs" -Type DWord -Value 32768
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "VolumeType" -Type String -Value "VHDX"

# Recommended optimization settings
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "FlipFlopProfileDirectoryName" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "ConcurrentUserSessions" -Type DWord -Value 1
