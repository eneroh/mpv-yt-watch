# mpv-yt-watch
A command line utility combining both mpv and yt-dlp to allow users to watch and/or download youtube videos via their terminal, completely browserless.

## Features ##
- Responsive terminal based interface
- Video resolution options from 144p to 4K
- Support for youtube videos that contain different languages i.e. Korean, Japanese etc.
- Video streaming functionality
- Option to download video at end of script
- Ability to change file extensions via the script
- Now Streaming: "Video Title" Display Environment/Window Manager notification integration

## Philosophy ##
mpv-yt-watch intends to: K.I.S.S. Keep it simple, stupid.
<br>
<br>
S - Simple: Minimal dependencies (mpv, yt-dlp that's about it)
<br>
<br>
U - User focused: You do not NEED degree to use this and inputs and code will be clear and concise (exampe text and expanded flags)
<br>
<br>
S - Speed oriented: The command time will be utilized when testing similar commands to determine the fastest. Ensuring quick outputs [time <command>], as well as, keep big/time consuming commands outside of loops
<br>
<br>
C - Compatible: The ability to work the same/similar on as many devices as possible with limited degraded performance (i.e. smartphones, pc's, desktops, servers, maybe IoT [try to run mpv-yt-watch on a fridge lol])
<br>
<br>
M - Minimal: Utilize bash functionality as much as possible instead of relying on other outside packages, as well as, utilize dependencies flags/tacs where necessary and not where excessive
<br>
<br>
F - Follow rules: Follow bash best practices, as closely as possible & validate script through shellcheck to ensure there are no errors
<br>
<br>
In short, SUSC MF

## Potential upgrades ##
- Internal script flags/tacs to speed past the interactivity and give the power user immediate control/less handholding
- Channel selection (needs to be a feature within yt-dlp), research indicates that this is possible. Touching base with suggestor to understand parameters before implementation
- URL mode toggle/option

## Cancelled ideas ##
- Confirmation on search variable before proceeding. Will likely require while, while not Y, return back to the initial search - too messy coding-wise
- Implementation of bash maps: https://bashcommands.com/bash-map to simplify if statements - no longer required

## Completed tasks ## 
- File extension options (instead of having the default webm, you can use the option of mp4)
- Adding video stream option functionality, you no longer will HAVE to download the file locally onto your machine. This should also resolve the issue of: [] $. At least for streaming. Pending download option fix.
- Video download now optional, not required
- Certain symbols specifically, [] $ mess with the download $result variable at ls | grep -i $result. Returning blank. Can be observed when downloading video: bazooka granny (LMAO)
- Notify-send notification connectivity is now in place. Provide feedback on positive or negative
- Simplified and sanitized both inputs and outputs
- Full script bash validation with no errors
- printf formatting is done in its entirety: unsigned integers, strings, escape seq. handling etc.
- Added native yt-dlp commands to improve outputs

## Special Thanks ##
mpv & yt-dlp - both have no idea I exist but this project is nothing without them
<br>
another-danny - Fellow bash enthusiast aha
<br>
shellcheck - making my code better
<br>
geeksforgeeks.org - the printf article was a life saver

## Known Issues ##
- If you use this script excessively on the same video (during testing specifically), your ip does get logged as a bot for an hour or two, during this time you are unable to watch videos. Sign in apparently fixes this, haven't tried this but not particularly a hassle. VPN is a workaround. [This issue is now very limited, unless you download videos constantly... Hours on end.]
