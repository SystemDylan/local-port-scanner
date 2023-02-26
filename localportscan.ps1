# Set the maximum port number to scan and initialize the completed ports counter
$totalPorts = 1000
$completedPorts = 0

# Display a message to indicate that the scan has started
Write-Host "Scanning ports on localhost..."

# Loop through all ports and check if a connection can be established
for ($port = 1; $port -le $totalPorts; $port++) {
  # Create a new TcpClient object to attempt a connection
  $client = New-Object System.Net.Sockets.TcpClient
  $result = $client.BeginConnect('127.0.0.1', $port, $null, $null)

  # Wait for the connection to complete
  Start-Sleep -Milliseconds 100

  # Check if the connection was successful
  if ($client.Connected) {
    Write-Host "Port $port : OPEN"
  }

  # Close the TcpClient object
  $client.Close()

  # Update progress by incrementing the completed ports counter and calculating the percentage complete
  $completedPorts++
  $percentComplete = [int]($completedPorts / $totalPorts * 100)

  # Display progress bar
  Write-Progress -Activity "Scanning ports" -Status "Progress" -PercentComplete $percentComplete
}

# Display a message to indicate that the scan has completed
Write-Host "Scan complete."