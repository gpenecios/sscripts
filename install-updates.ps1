# ============================
#  LOAD HIGHEST VERSION OF PSWindowsUpdate
# ============================

$AllVersions = Get-Module -ListAvailable PSWindowsUpdate |
               Sort-Object Version -Descending

$Selected = $AllVersions[0]   # pick highest version
Import-Module $Selected -Force

$Major = $Selected.Version.Major
$Minor = $Selected.Version.Minor

Write-Output "Loaded PSWindowsUpdate version: $Major.$Minor"


# ============================
#  LOGGING SETUP
# ============================

$ServerName = $env:COMPUTERNAME
$Cpath = "C:\scripts\glennp\logs"
$LogFile = "$Cpath\$ServerName-update.log"
$KBArticles = "KB2267602,KB5081461,KB890830"
#  *******************
#KB2267602 	- Security Intelligence Update
#KB5081461 	- AzureConnectedMachineAgent
#KB890830 	- Win Malicious Software Removal
#  *******************
if (-not (Test-Path $Cpath)) {
    New-Item -ItemType Directory -Path $Cpath | Out-Null
}


# ============================
#  RUN UPDATE BASED ON VERSION
# ============================

if ($Major -eq 1) {
    "Using Get-WUInstall (v1.x)" | Out-File $LogFile -Encoding UTF8

    Get-WUInstall -Verbose -IgnoreReboot -AcceptAll `
        -KBArticleID $KBArticles |
        Out-File $LogFile -Append -Encoding UTF8
}
elseif ($Major -eq 2) {
    "Using Install-WindowsUpdate (v2.x)" | Out-File $LogFile -Encoding UTF8

    Install-WindowsUpdate -Verbose -WindowsUpdate -IgnoreReboot -AcceptAll `
        -KBArticleID $KBArticles |
        Out-File $LogFile -Append -Encoding UTF8
}
elseif ($Major -ge 3) {
    "Using Get-WindowsUpdate (v3.x)" | Out-File $LogFile -Append -Encoding UTF8

    Get-WindowsUpdate -Verbose -WindowsUpdate -Install -IgnoreReboot -AcceptAll `
        -KBArticleID $KBArticles |
        Out-File $LogFile -Append -Encoding UTF8
}
else {
    "ERROR: Unsupported PSWindowsUpdate version." |
        Out-File $LogFile -Append -Encoding UTF8
}