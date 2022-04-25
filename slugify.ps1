
# Converts any text into file friendly format
Function ConvertTo-Slug
{
    <#
    .SYNOPSIS
    Slugify a String in entry

    .DESCRIPTION
    This function "slugifies" a string given in entry

    .PARAMETER Text
    String. Text to slugify

    .PARAMETER Delimiter
    String. Optional, the delimiter used. If omitted, "-" will be used

    .PARAMETER CapitalizeFirstLetter
    Switch. If the switch is set, it will capitalize the first letter of each word in the "Text" string.

    .EXAMPLE
    PS> ConvertTo-Slug "That's all folks!"
    Will return "thats-all-folks"

    .EXAMPLE
    PS> ConvertTo-Slug "That's all Folks!" -Delimiter "_"
    Will return "thats_all_folks"

    .EXAMPLE
    PS> ConvertTo-Slug "That's all Folks!" -Delimiter "" -CapitalizeFirstLetter
    Will return "ThatsAllFolks"

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True, Position = 0)]
        [String]
        $Text,

        [Parameter(Mandatory = $False, Position = 1)]
        [string]
        $Delimiter = "-",

        [Parameter()]
        [Switch]
        $CapitalizeFirstLetter
    )

    $bytes = [System.Text.Encoding]::GetEncoding("Cyrillic").GetBytes($text)
    $result = [System.Text.Encoding]::ASCII.GetString($bytes).ToLower()


    if ($CapitalizeFirstLetter)
    {
        $TextInfo = (Get-Culture).TextInfo
        $result = $TextInfo.ToTitleCase($result)
    }

    $rx = [System.Text.RegularExpressions.Regex]
    $result = $rx::Replace($result, "[^a-zA-Z0-9\s-]", "")
    $result = $rx::Replace($result, "\s+", " ").Trim();
    $result = $rx::Replace($result, "\s", $Delimiter);
    Write-Output $result
}
