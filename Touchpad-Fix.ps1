$deviceId = "ACPI\YOUR_DEVICE_ID_HERE"
log = "C:\Scripts\touchpad_log.txt"

Add-Content $log "$(Get-Date) - Script started"

$maxTries = 10
$delay = 3 # seconds
$found = $false

for ($i=1; $i -le $maxTries; $i++) {
    $device = Get-PnpDevice -InstanceId $deviceId -ErrorAction SilentlyContinue
    if ($device) {
        $found = $true
        break
    } else {
        Start-Sleep -Seconds $delay
    }
}

if ($found) {
    Disable-PnpDevice -InstanceId $deviceId -Confirm:$false
    Start-Sleep -Seconds 2
    Enable-PnpDevice -InstanceId $deviceId -Confirm:$false
    Add-Content $log "$(Get-Date) - Script finished successfully"
} else {
    Add-Content $log "$(Get-Date) - ERROR: Device not found after $($maxTries*$delay) seconds"
}
