#Post in Teams General-Alerts Channel
$script = "teamswebhook.ps1"
$scriptdir = "C:\scripts\glennp\sscripts"

$webhook = "https://default44467e6f462c4ea2823f7800de5434.e3.environment.api.powerplatform.com:443/powerautomate/automations/direct/workflows/bb3c6e365cd146acaae2927340be683d/triggers/manual/paths/invoke?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=aw3h79I8xuD9x8Nja15deutMdW1aBkN03jJUr5Ku21E"

# Server Info
$ServerName = $env:computername
$LogDir = "c:\scripts\glennp\logs"
$LogFile = "$LogDir\$ServerName-update.log"
$bodymsg = get-content -path "$LogFile" -Raw


$curtime = Get-Date -Format "HH:mm:ss"
$title = "Log: Azure Agent Update"
$severity = "LOW"
$msg = $bodymsg
#$msg = "This is a test message --> $severity --> $curtime"
$scriptlog = "$LogDir\$script.log"
$scriptpath = "$scriptdir\$script"

# Run the script
Powershell -ExecutionPolicy ByPass -File $scriptpath -message $msg -webhookurl $webhook -title $title -Severity $severity > $log 2>&1