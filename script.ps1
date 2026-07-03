# 1. Define your webhook URL and the message string
$WebhookUrl = "https://discord.com/api/webhooks/1459617169292660806/O2L5KXLylvxvqHe1niDyTGYFuQf1tDgTe5BqE8jhdYCcppOwnJOUNyBNXyzRHelTYWS8"
$Message    = "Hello from PowerShell! This is my raw text string."

# 2. Package the string into the standard Discord JSON format
$Body = @{
    content = $Message
} | ConvertTo-Json

# 3. Send it to Discord
Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $Body -ContentType "application/json"
