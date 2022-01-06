function log4youtube($yt_url, $timestamp_list) {
    $url = ($yt_url -contains "=") ? $($yt_url -split "=")[1]:$($yt_url -split "=")[3]
    [string]$timestamp_doc
    ForEach ($item in $timestamp_list) {
        if ($item[2] -match "^\d{4}$") {
            Write-Host "MrDwarf spins off this event: $($item[2]) ~> $($item[3])"
            hmv -year $item[2] -title $item[3] -content $item[4]
            #$item = $item[0, 1, 2, 4]
        }
        $hour, $min, $description = $item
        $second_stamp = (New-TimeSpan -Hours $hour -Minutes $min).TotalSeconds
        $yt_url = $url + "?t=" + $second_stamp
        $timestamp_doc += "* [${hour}h:${min}min](${yt_url}) $($description -join " ")`n"
    }
    Write-Host $timestamp_doc
    $timestamp_doc | x
    <#
    .SYNOPSIS
    - pass youtube URL with a an array or arrays in the form of @((<hour>,<min>,<note>),...)
    #>
}
