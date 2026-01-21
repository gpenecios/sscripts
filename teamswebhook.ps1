param (
    [Parameter(Mandatory = $true)]
    [string]$WebhookUrl,

    [Parameter(Mandatory = $true)]
    [string]$Message,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Low", "Medium", "High")]
    [string]$Severity,

    [Parameter(Mandatory = $false)]
    [string]$Title = "Teams Notification"
)

# Generate timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Get host name
$hostName = $env:COMPUTERNAME

# Set theme color based on severity
switch ($Severity) {
    "Low"    { $themeColor = "00AA00" } # Green
    "Medium" { $themeColor = "FFFF00" } # Yellow
    "High"   { $themeColor = "FF0000" } # Red
}

# Build MessageCard payload
$payload = @{
    "@type"    = "MessageCard"
    "@context" = "http://schema.org/extensions"
    summary   = "$Title - $Severity"
    themeColor = $themeColor
    title     = "$Title [$Severity]"
    sections  = @(
        # Facts section
        @{
            facts = @(
                @{ name = "Severity: ";  value = $Severity },
                @{ name = "Host: ";      value = $hostName },
                @{ name = "Timestamp: "; value = $timestamp }
            )
        },
        # Description section (message LAST)
        @{
            text = "**Description:**`n$message"
        }
    )
} | ConvertTo-Json -Depth 5

# Send message to Microsoft Teams
Invoke-RestMethod `
    -Uri $WebhookUrl `
    -Method Post `
    -ContentType "application/json" `
    -Body $payload
