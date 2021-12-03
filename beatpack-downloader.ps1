# Url to download maps
$kitsu = "https://kitsu.moe/d/"

$path = Read-Host -Prompt "Enter path for osu Songs folder"
[int]$parameter1 = Read-Host -Prompt "Enter pack range start"
[int]$parameter2 = Read-Host -Prompt "Enter pack range end"
$ProgressPreference = 'SilentlyContinue'

While ($parameter1 -le $parameter2){
  
    Write-Output "Now Downloading Pack $parameter1 Out Of $parameter2"

    $url = "https://osu.ppy.sh/beatmaps/packs/$parameter1"
    $responce = (Invoke-WebRequest -Uri $url).Links.href
    $filter = $responce | Select-String -Pattern "https://osu.ppy.sh/beatmapsets/"
    $mapset = $filter -replace "https://osu.ppy.sh/beatmapsets/"

    $mapset | ForEach-Object {
        Invoke-WebRequest -Uri $kitsu+$_ -OutFile $path\$_.osz -UseBasicParsing
        Start-Sleep -Seconds 2
    }
    $parameter1 = $parameter1 + 1

}