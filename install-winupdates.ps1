Import-Module PSWindowsUpdate

#Install-Module -Name PSWindowsUpdate -Force; get-windowsupdate -verbose

$ServerName = $env:computername
#$Cpath = (Get-Location).Path
$Cpath = "c:\scripts\glennp\logs"
$LogFile = "$Cpath\$ServerName-update.log"

# Install update for AzureAgent,Malicious Software Removal Tool, MS Defender
Install-WindowsUpdate -Verbose -IgnoreReboot -AcceptAll -KBArticleID 5077633,2267602,890830 | Out-file $LogFile -Encoding UTF8