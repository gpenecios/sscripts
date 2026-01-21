#Post in Teams General-Alerts Channel
$script = "teamswebhook.ps1"
$scriptdir = "C:\engrit\scripts\pshell"
$webhook = "https://default44467e6f462c4ea2823f7800de5434.e3.environment.api.powerplatform.com:443/powerautomate/automations/direct/workflows/bb3c6e365cd146acaae2927340be683d/triggers/manual/paths/invoke?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=aw3h79I8xuD9x8Nja15deutMdW1aBkN03jJUr5Ku21E"

$curtime = Get-Date -Format "HH:mm:ss"
$title = "Teams Notify"
$severity = "HIGH"
$msg = "This is a test message --> $severity --> $curtime"
$log = "C:\engrit\logs\$script.log"
$scriptpath = "$scriptdir\$script"

# Run the script
Powershell -ExecutionPolicy ByPass -File $scriptpath -message $msg -webhookurl $webhook -title $title -Severity $severity > $log 2>&1