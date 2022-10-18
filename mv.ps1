function create-event{
    param (
        [Parameter(Mandatory=$true)][string]$year,
        [Parameter(Mandatory=$true)][string]$title,
        [Parameter(Mandatory=$true)][string]$content,
        [Parameter(Mandatory=$true)][string]$url
    )
    $template = "${env:MV_FOLDER}\event_template.md"
    $invalid_characters = "[^-A-Za-z0-9_\.]"
    $title = "$title" -replace $invalid_characters, "-"
    $new_event_in_software = "${env:MV_FOLDER}\text\${year}-${title}.md"
    New-Item $new_event_in_software
    Get-Content $template | Set-Content $new_event_in_software
    (Get-Content -Path $new_event_in_software -Raw) -replace "### 1. notes", "$&`n* $content`n" | 
        Set-Content $new_event_in_software
    (Get-Content -Path $new_event_in_software -Raw) -replace "### 2. links", "$&`n* $url`n" | 
        Set-Content $new_event_in_software
    if(Read-Host "Open Event? (y/Enter)"){vim $new_event_in_software}
    
}

If ($MyInvocation.InvocationName -eq '.') { create-event }