# url to kitsu (how we actually download the maps)
$kitsu = "https://kitsu.moe/d/"

# Using Read-Host -Prompt to store user inputs into variables
$path = Read-Host -Prompt "Enter path for osu Songs folder"
$parameter1 = Read-Host -Prompt "Enter pack range start"
$parameter2 = Read-Host -Prompt "Enter pack range end"

# This is the main work horse
# The while statement compares our two user range inputs and campares them
While ($parameter1 -le $parameter2){

# Write-Output here just lets you know where you are in the pack download    
    Write-Output "Now Downloading Pack $parameter1 Out Of $parameter2"

# Here we set the variable $url to equal the osu beatmap pack url with the user defined parameter on the end    
    $url = "https://osu.ppy.sh/beatmaps/packs/$parameter1"
# Invoke-WebRequest is used to scrape the osu website
# .Links tells it to only grab links
# .href tells it to only grab links with the href condition
# This all gets stored into the variable $responce    
    $responce = (Invoke-WebRequest -Uri $url).Links.href
# Here it calls $responce variable and use Select-String -Pattern to filter the links
# If this didn't get done every link from the website would get saved     
    $filter = $responce | Select-String -Pattern "https://osu.ppy.sh/beatmapsets/"
# $filter gets called and run through -replace
# This removes all of the url leaving only the beatmap IDs behind
    $mapset = $filter -replace "https://osu.ppy.sh/beatmapsets/"

# $mapset gets called and ran through ForEach-Object
# This allows BitsTransfer to run through all of the map IDs so it can download them    
    $mapset | ForEach-Object {
# Here BitsTransfer will combine $kitsu (The url to actually download) and the map id
# Then -Destination gets set to the user defined Songs $path and $_.osz (which is the map id with .osz added on the end)
        Start-BitsTransfer -Source $kitsu+$_ -Destination $path\$_.osz
# This is a two second wait, only used to not piss off the owners of Kitsu        
        Start-Sleep -Seconds 2
    }
# $parameter1 gets reset here by adding a 1 onto the end of it
    $parameter1 = $parameter1 + 1

}