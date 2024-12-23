Start-Transcript -Path "C:\Scripts\Transcript$(((get-date).ToUniversalTime()).ToString("yyyyMMdd_hhmmss")).txt" -Append
$SQLService="SQL Server (MSSQLSERVER)”
$SQLAgentService="SQL Server Agent (MSSQLSERVER)"
$tempfolder="D:\MSSQL\tempdb"
if (!(test-path -path $tempfolder)) {
   New-Item -ItemType directory -Path $tempfolder
}
Start-Service $SQLService
Start-Service $SQLAgentService