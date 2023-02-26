$totalPorts = 1000
$completedPorts = 0
Write-Host "Scanning ports on localhost..."

for ($port = 1; $port -le $totalPorts; $port++) {
  $client = New-Object System.Net.Sockets.TcpClient
  $result = $client.BeginConnect('127.0.0.1', $port, $null, $null)
  Start-Sleep -Milliseconds 100  # Wait for the connection to complete
  if ($client.Connected) {
    Write-Host "Port $port : OPEN"
  }
  $client.Close()

  # Update progress
  $completedPorts++
  $percentComplete = [int]($completedPorts / $totalPorts * 100)
  Write-Progress -Activity "Scanning ports" -Status "Progress" -PercentComplete $percentComplete
}

Write-Host "Scan complete."
