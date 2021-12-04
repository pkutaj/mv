function create-event{
    param (
        [Parameter(Mandatory=$true)][string]$year,
        [Parameter(Mandatory=$true)][string]$title,
        [string]$content
    )
    $template = "${env:MV_FOLDER}\event_template.md"
    $invalid_characters = "[^-A-Za-z0-9_\.]"
    $title = "$title" -replace $invalid_characters, "-"
    $folders = (dir -dir).Name
    $folders | ForEach-Object {
        if($_.Substring(0,3) -eq $year.Substring(0,3)) {
            $new_event_in_software = "${env:MV_FOLDER}\${_}\${year}-${title}.md"
            New-Item $new_event_in_software
            Get-Content $template | Set-Content $new_event_in_software
            if(Read-Host "Open Event? (y/Enter)"){Invoke-Item $new_event_in_software}
        }
    }
    
}

If ($MyInvocation.InvocationName -eq '.') { create-event }