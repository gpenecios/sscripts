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

if (-not (Test-Path $Cpath)) {
    New-Item -ItemType Directory -Path $Cpath | Out-Null
}


# ============================
#  RUN UPDATE BASED ON VERSION
# ============================

if ($Major -eq 1) {
    "Using Get-WUInstall (v1.x)" | Out-File $LogFile -Encoding UTF8

    Get-WUInstall -Verbose -IgnoreReboot -AcceptAll `
        -KBArticleID 5077633,2267602,890830 |
        Out-File $LogFile -Append -Encoding UTF8
}
elseif ($Major -eq 2) {
    "Using Install-WindowsUpdate (v2.x)" | Out-File $LogFile -Encoding UTF8

    Install-WindowsUpdate -Verbose -IgnoreReboot -AcceptAll `
        -KBArticleID 5077633,2267602,890830 |
        Out-File $LogFile -Append -Encoding UTF8
}
elseif ($Major -ge 3) {
    "Using Get-WindowsUpdate (v3.x)" | Out-File $LogFile -Append -Encoding UTF8

    Get-WindowsUpdate -Verbose -Install -IgnoreReboot -AcceptAll `
        -KBArticleID 5077633,2267602,890830 |
        Out-File $LogFile -Append -Encoding UTF8
}
else {
    "ERROR: Unsupported PSWindowsUpdate version." |
        Out-File $LogFile -Append -Encoding UTF8
}