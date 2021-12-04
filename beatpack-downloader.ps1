$Beatconnect = "https://beatconnect.io/b/"

$path = Read-Host -Prompt "Enter path for osu Songs folder"
[int]$parameter1 = Read-Host -Prompt "Enter pack range start"
[int]$parameter2 = Read-Host -Prompt "Enter pack range end"

While ($parameter1 -le $parameter2){
  
    Write-Output "Now Downloading Pack $parameter1 Out Of $parameter2"

    $osuurl = "https://osu.ppy.sh/beatmaps/packs/$parameter1"
    $responce = (Invoke-WebRequest -Uri $osuurl).Links.href
    $filter = $responce | Select-String -Pattern "https://osu.ppy.sh/beatmapsets/"
    $mapset = $filter -replace "https://osu.ppy.sh/beatmapsets/"

    $mapset | ForEach-Object {
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($Beatconnect+$_, "$path\$_.osz")
        Start-Sleep -Seconds 3
    }

    $parameter1 = $parameter1 + 1

}