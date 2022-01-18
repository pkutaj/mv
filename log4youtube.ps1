function log4youtube($yt_url, $timestamp_list) {
    $url = ($yt_url -match "=") ? $($yt_url -split "=")[1]:$($yt_url -split "/")[3]
    [string]$timestamp_doc
    ForEach ($item in $timestamp_list) {
        if ($item[2] -match "^\d{4}$") {
            Write-Host "MrDwarf spins off this event: $($item[2]) ~> $($item[3])"
            hmv -year $item[2] -title $item[3] -content $item[4]
            #$item = $item[0, 1, 2, 4]
        }
        $hour, $min, $description = $item
        $second_stamp = (New-TimeSpan -Hours $hour -Minutes $min).TotalSeconds
        $yt_url = "https://youtu.be/" + $url + "?t=" + $second_stamp
        $timestamp_doc += "* [${hour}h:${min}min](${yt_url}) $($description -join " ")`n"
    }
    Write-Host $timestamp_doc
    $timestamp_doc | x
    <#
    .SYNOPSIS
    - pass youtube URL with a an array or arrays in the form of @((<hour>,<min>,<note>),...)
    #>
}

log4youtube -yt_url "https://www.youtube.com/watch?v=phk0w1dGYic" -timestamp_list @(
    (1, 12, "John Doerr formed the management team at Netscape"),
    (1, 15, "First contact between Clark and Andreesen who was fed up with browsers at that timeM But Marc had an idea that all his friends are graduating and are for grabs. So let's rewrite Mosaic without looking at the code - decision under time pressure. It took 3 months of talking what should be done"),
    (1, 20, "First, MarcA was established as a leader. Jim is an elderly investor."),
    (1, 25, "First year Seventy million of revenue from selling to companies. But it was a bubbly time."),
    (1, 28, "On relationships with University of Illinois - had they treated their students with respect they would  capitalize on it later in the form of donations (clark gave stanford almost two hundreds mil $)"),
    (1, 35, "Netscape made e-commerce possible.SSL. Before no security protocol.")
    (1, 47, "We probably threw too much salt in the eyes of Microsoft")
)