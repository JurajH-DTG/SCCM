<#$Date = Get-Date
$RP = Get-Item -Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol"
$Diff = $Date - $RP.LastWriteTime
if($Diff.TotalDays -ge 28 -or $RP.Length -lt 1){
Write-Host "ee"
# Remove-Item -Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol" -Force
}
#>

$pol_file = $(Join-Path $env:windir 'System32\GroupPolicy\Machine\Registry.pol')
if (-not (Test-Path -Path $pol_file -PathType Leaf -ErrorAction SilentlyContinue)) {
    $status = "Policy file missing"
    Write-Host $status
}
else {

    [Byte[]]$pol_file_header = Get-Content -Encoding Byte -Path $pol_file -TotalCount 4 -ErrorAction SilentlyContinue

    $status = "Policy file exists"
    if (($pol_file_header -join "") -eq "8082101103") {
        $corrupt = 0
    }
    else {
        $corrupt = 1
        Remove-Item -Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol" -Force
        Write-Host "Corrupted Policy file - deleted"
    }
    

$Date = Get-Date
$RP = Get-Item -Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol"
$Diff = $Date - $RP.LastWriteTime
$VelkostRP = $RP.Length
$rozdiel = $Diff.days
if($rozdiel -ge 5 -and $corrupt -eq 0) {
  Remove-Item -Path "C:\Windows\System32\GroupPolicy\Machine\Registry.pol" -Force
  Write-Host "Policy file to old - $rozdiel Days - deleted"}
  else {
Write-Host " File is $rozdiel Days old and Size is $VelkostRP bytes"}
}
