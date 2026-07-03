# 1. Define your webhook URL and the message string
$WebhookUrl = "https://discord.com/api/webhooks/1522586603615162469/cSzV4hP6LxzHVQKQjOH7ZKAjKSL9Dd_dXSzbSzViTz-DvlS2C1J7aSZkG3tD871SCXwY"
$Message    = "Hello from PowerShell! This is my raw text string."

# 2. Package the string into the standard Discord JSON format
$Body = @{
    content = $Message
} | ConvertTo-Json

# 3. Send it to Discord
Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $Body -ContentType "application/json"
