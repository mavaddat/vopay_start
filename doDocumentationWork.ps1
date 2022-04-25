Import-Module .\slugify.ps1

function script:Start-DocsWork
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [String[]]
        $files
    )
    Push-Location ".\source\_includes"
    for ($i = 0; $i -lt $files.Length; $i++)
    {
        if ($i + 1 -lt $files.Length)
        {
            $Title = Get-Content $files[$i + 1] | Select-String -Pattern "(?<=^\#+ )(.+)$" -Context 0 | Select-Object -First 1 | ForEach-Object { $_.Matches.Groups[1].Value }
            Write-Host "The next file will be: '$($files[$i + 1])' ('$Title')"
            # if ($npmRunStart.HasMoreData) { $npmRunStart | Receive-Job -Keep }
        }
        code.cmd $($files[$i]) --wait
    }
    Pop-Location
}

# npm run start in a new threadjob
<#
$npmRunStart = Start-ThreadJob -ScriptBlock {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $Directory
    )
    Set-Location $Directory
    npm run start
} -Name "npm run start" -ArgumentList @($PWD)
 #>
if ($args -contains "-Start")
{
    # Copy the Slack message from Faizal to the clipboard
    # Dump the message into a txt file
    if (-not (Test-Path plan.txt)) { Get-Clipboard | Out-File -FilePath plan.txt }
}
if ($args -contains "-FromMd")
{
    $files = Get-Content -Path ".\source\index.md" -Raw | Select-String -Pattern "(?m)(?<=^includes:[`n`r]+)([\s\S]+?)[`n`r]{2}" | ForEach-Object { $_.Matches.Groups[1].Value } | Select-String -Pattern "(?m)(?<=- )(.+)$" -AllMatches | ForEach-Object { $_.Matches.Value }
    Start-DocsWork($files)
}
elseif ($args -contains "-FromPlan")
{
    # Iterate through the lines of the file to do work
    $plan = Get-Content plan.txt | ForEach-Object {
        $slug = ConvertTo-Slug $_
        Get-Item ".\source\_includes\$slug.md"
    }
    Start-DocsWork($plan)
}
elseif ($args -contains "-GetHTML")
{
    $files = Get-Content -Path ".\source\index.md" -Raw | Select-String -Pattern "(?m)(?<=^includes:[`n`r]+)([\s\S]+?)[`n`r]{2}" | ForEach-Object { $_.Matches.Groups[1].Value } | Select-String -Pattern "(?m)(?<=- )([^\.]+)(?=\.md$)" -AllMatches | ForEach-Object { $_.Matches.Value }
    # Open each file in chrome.exe and wait for it to close
    foreach ($file in $files)
    {
        Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList $(Get-Item "$env:USERPROFILE\Documents\out\$file.html") -Wait
        Start-Sleep -Seconds 5
    }

}

# $npmRunStart.StopJobAsync() && $npmRunStart | Receive-Job -AutoRemoveJob -Wait
