Import-Module PSWindowsUpdate

#Install-Module -Name PSWindowsUpdate -Force; get-windowsupdate -verbose

$ServerName = $env:computername
$Cpath = (Get-Location).Path
$LogFile = "$Cpath\$ServerName-update.log"

# Install update for AzureConnector and MS Defender
Install-WindowsUpdate -Verbose -IgnoreReboot -AcceptAll -KBArticleID 5077633,2267602 | Out-file $LogFile -Encoding UTF8