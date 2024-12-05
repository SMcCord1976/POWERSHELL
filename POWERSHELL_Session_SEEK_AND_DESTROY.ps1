$servers = Get-Content -Path "C:\temp\Servers_I_MIGHT_be_logged_into_for_PS_session_kill_script.txt"

$loggedInServers = @()
$unreachableServers = @()

$totalServers = $servers.Count
$counter = 1

foreach ($server in $servers) {
    Write-Host "Processing server $counter of $totalServers $server..." -ForegroundColor Cyan
    
    try {
        $sessions = qwinsta /server:$server 2>&1

        if ($sessions -match "Error") {
            throw "Server unreachable"
        }

        $userSessions = $sessions | Where-Object { $_ -match $env:USERNAME }

        if ($userSessions) {
            foreach ($session in $userSessions) {
                # Extract session ID (usually the third item in the output line)
                $sessionId = ($session -split "\s+")[2]
                Write-Host "Logging off session $sessionId on $server..." -ForegroundColor Yellow
                logoff $sessionId /server:$server
                $loggedInServers += "$server - Session ID: $sessionId (Logged off)"
            }
        } else {
            Write-Host "No active or disconnected sessions found for user on $server." -ForegroundColor Green
        }
    } catch {
        Write-Host "Could not connect to $server. Server may be unreachable or not accepting connections." -ForegroundColor Red
        $unreachableServers += $server
    }

    $counter++
}

# Summary output
Write-Host "`nSummary:" -ForegroundColor White

if ($loggedInServers.Count -gt 0) {
    Write-Host "You were logged off from the following servers:" -ForegroundColor Green
    $loggedInServers | ForEach-Object { Write-Host $_ -ForegroundColor Green }
} else {
    Write-Host "No sessions were found for your user on any of the servers in the list." -ForegroundColor Yellow
}

if ($unreachableServers.Count -gt 0) {
    Write-Host "`nThe following servers were unreachable:" -ForegroundColor Red
    $unreachableServers | ForEach-Object { Write-Host $_ -ForegroundColor Red }
}
