# Get the current user's SID
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$sid = $currentUser.User.Value

# Define the path of the CSV file
$filePath = "\\LUC-FS02\UPD\RDPGuardian_UDP\sid_query.csv"

# Check if the file exists; if not, create it with the header
if (-Not (Test-Path $filePath)) {
    "AccountName" | Out-File -FilePath $filePath -Encoding utf8
}

# Read existing SIDs from the CSV file
$existingSIDs = Get-Content -Path $filePath | Select-Object -Skip 1  # Skip header line

# Check if the SID already exists in the file
if ($existingSIDs -notcontains $sid) {
    # Append the SID to the CSV file
    $sid | Out-File -FilePath $filePath -Append -Encoding utf8
    Write-Host "SID has been added to Array. Your profile is being reconnected, please wait: '$sid'"
} else {
    Write-Host "SID already exists in Array. Your profile is being reconnected, please wait: '$sid'"
}