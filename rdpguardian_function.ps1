# Import the CSV file containing the account names
$csvFilePath = "\\luc-fs02\UPD\RDPGuardian_UDP\sid_query.csv"  # Update this path
$accountNames = Import-Csv -Path $csvFilePath | Select-Object -ExpandProperty AccountName -ErrorAction Ignore

# Get all open file handles on the system (SMB shares)
$openFiles = Get-SmbOpenFile

# Loop through each account name and find matching open files
foreach ($accountName in $accountNames) {
    $matchingFiles = $openFiles | Where-Object { $_.Path -like "*$accountName*" }

    foreach ($file in $matchingFiles) {
        try {
            # Attempt to close the open file handle
            Close-SmbOpenFile -FileId $file.FileId -Force
            Write-Host "Closed file: $($file.Path) for account: $accountName"
        } catch {
            Write-Host "Failed to close file: $($file.Path) for account: $accountName. Error: $_"
        }
    }
}
Remove-Item -Path "\\luc-fs02\UPD\RDPGuardian_UDP\sid_query.csv" -ErrorAction Ignore
