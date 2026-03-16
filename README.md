# mpv-yt-watch
A combination of both mpv and yt-dlp to allow users to watch youtube videos via their terminal, completely browserless.

### Features ###
- Responsive terminal based interface
- Video resolution options from 240p to 4K
- Support for youtube videos that contain different languages i.e. Korean, Japanese etc.

### Potential upgrades ###
- Confirmation on search variable before proceeding. Will likely require while, while not Y, return back to the initial search 
- Internal script flags/tacs to speed past the interactivity and give the power user immediate control/less handholding
- Implementation of bash maps: https://bashcommands.com/bash-map to simplify if statements
- Channel selection (needs to be a feature within yt-dlp), will review later
- URL mode toggle/option
- Adding video stream option functionality, you no longer will HAVE to download the file locally onto your machine. This should also resolve the issue of: [] $. At least for streaming. Pending download option fix.
- File extension options (instead of having the default webm, you can use the option of mp4)

### Known Issues ###
- Certain symbols specifically, [] $ cause the result variable to not work correctly, breaking communication with mpv and erroring out overall
- If you use this script excessively on the same video (during testing specifically), your ip does get logged as a bot for an hour or two, during this time you are unable to watch videos. Sign in apparently fixes this, haven't tried this but not particularly a hassle. VPN is a workaround.
