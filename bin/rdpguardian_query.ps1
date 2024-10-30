# Define the output CSV file path
$outputFilePath = "D:\UPD\RDPGuardian_UDP\sid_fsquery.csv"
$deduplicatedFilePath = "D:\UPD\RDPGuardian_UDP\sid_fsquery.csv"

# Get the current time and calculate the cutoff time for the last 5 minutes
$endTime = Get-Date
$startTime = $endTime.AddMinutes(-5)

# Retrieve the Security log entries for logoff events in the last 5 minutes
$logoffEvents = Get-WinEvent -FilterHashtable @{
    LogName = 'Security';
    Id = 4634; # Event ID for logoff
    StartTime = $startTime;
    EndTime = $endTime
} | Select-Object @{Name='AccountName'; Expression={($_.Properties[0].Value)}}

# Export the results to a CSV file
$logoffEvents | Export-Csv -Path $outputFilePath -NoTypeInformation

# Read the CSV file and remove duplicates
$deduplicatedEvents = Import-Csv -Path $outputFilePath | Sort-Object AccountName -Unique

# Export the deduplicated results to a new CSV file
$deduplicatedEvents | Export-Csv -Path $deduplicatedFilePath -NoTypeInformation

Write-Host "Logoff events exported to $outputFilePath"
Write-Host "Deduplicated logoff events exported to $deduplicatedFilePath"
