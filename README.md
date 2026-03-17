# mpv-yt-watch
A combination of both mpv and yt-dlp to allow users to watch youtube videos via their terminal, completely browserless.

### Features ###
- Responsive terminal based interface
- Video resolution options from 144p to 4K
- Support for youtube videos that contain different languages i.e. Korean, Japanese etc.
- Video streaming functionality
- Option to download video at end of script
- Ability to change file extensions via the script

### Potential upgrades ###
- Internal script flags/tacs to speed past the interactivity and give the power user immediate control/less handholding
- Implementation of bash maps: https://bashcommands.com/bash-map to simplify if statements
- Channel selection (needs to be a feature within yt-dlp), will review later
- URL mode toggle/option

### Cancelled ideas ###
- Confirmation on search variable before proceeding. Will likely require while, while not Y, return back to the initial search - too messy coding-wise

### Completed tasks ### 
- File extension options (instead of having the default webm, you can use the option of mp4)
- Adding video stream option functionality, you no longer will HAVE to download the file locally onto your machine. This should also resolve the issue of: [] $. At least for streaming. Pending download option fix.
- Video download now optional, not mandatory
  
### Known Issues ###
- Certain symbols specifically, [] $ mess with the download $result variable at ls | grep -i $result. Returning blank. Can be observed when downloading video: bazooka granny (LMAO)
- If you use this script excessively on the same video (during testing specifically), your ip does get logged as a bot for an hour or two, during this time you are unable to watch videos. Sign in apparently fixes this, haven't tried this but not particularly a hassle. VPN is a workaround. [This issue is now very limited, unless you download videos constantly... Hours on end.]
