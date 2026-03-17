#!/bin/bash

### mpv_yt_watch_v4.sh ###
# - Added search string functionality, now you no longer need a browser at all really
# - Need for url validation no longer required
# - Removed unnecessary usage of caching to stdoutput and stderr
# - Addition of 240p resolution option
# - Change over from search variable grep to cache variable grep, allowing for all language support (korean, japanese etc.) [may require wqy-zenhei on arch linux]
# - Replaced relevant echoes and reads with just reads, simplifying the code by a few lines
# - File extension selector implemented
# - File download option at the end of the script w/ confirmation prompt. More granularity to the user. You are welcome aha
# - Removed former single digit number based resolution. This is what broke the script previously and caused errors. You will now need to input a resolution but now there is no possibility for script breaking. WHATSOEVER. Don't test this aha
# - Inclusion of 144p video res, figured if I'm trying to compete, I might as well meet the youtube standard. 144p all the way to 4K. LETS GO BAYBEEEEEE!
# - If statements replaced with cases. Actually much better in this use case and fixed a lot of headaches.
# - I have tested numerous videos over numerous languages, video resolutions and extensions and I can't seem to break it anymore. If you are an experienced tester, please try and let me know.

read -rp "Input search string [ Song | Music Artist | Youtuber ]: " -- search
echo "You are searching for: $search"
searchFormat=$(yt-dlp ytsearch1:"$search" --list-formats)

formatExt=$(echo "${searchFormat}" | grep -e 'webm\|mp4' | grep -v 'audio only' | awk '{print $2;}' | sort -u | nl)
echo "$formatExt"
read -rp "Choose extension format (Default: empty) [1-2]: " -- formatExt
case $formatExt in
	1)
		ext=[ext=mp4]
	;;
	2)
		ext=[ext=webm]
	;;
	*)
	;;
esac

formattedSearch=$(echo "${searchFormat}" | grep -e '144p\|240p\|480p\|720p\|1080p\|1440p\|2160p' | awk '{print $14;}' | tr -s '\n' | tr -d ',' | uniq)

formattedLine=$(echo "$formattedSearch" | sed -e :a -e '$!N; s/\n/ | /; ta' | sed -e 's/p//g' )
read -rp "${formattedSearch[@]}"$'\n'"Choose video resolution format (Default: best) [ ${formattedLine} ]: " -- formatRes
formatRes=${formatRes:-$(echo "${formattedSearch[@]}" | sort -t p -n -k 1 | tail -1 | sed -e 's/p60//g' | sed -e 's/p//g' )}

case $formatRes in
	144)	
	;;
	240)
	;;
	480)
	;;
	720)
	;;
	1080)
	;;
	1440)
	;;
	2160)
	;;
	*)
		echo "Invalid option! Please try again"
		exit 1;
	;;
esac

videoUrl=$(yt-dlp --get-id ytsearch1:"$search")
videoUrl="https://youtube.com/watch?v=$videoUrl"

read -rp "Would you like to save a copy of this video: $search? [y/N]: " -- dlConfirm
dlConfirm=${dlConfirm:-N}

case $dlConfirm in
	y|Y)
		echo "Downloading file" 
		cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
		result=$(ls | grep -i "$cache")
		echo "Your video has been saved as $result"
		echo "Now Streaming: $search"
		mpv --ytdl-format="bestvideo$ext[height=$formatRes]+bestaudio" "$videoUrl"
		echo "Thank you for using mpv-yt-watch" 
	;;
	n|N)
		mpv --ytdl-format="bestvideo$ext[height=$formatRes]+bestaudio" "$videoUrl"
		echo "Thank you for using mpv-yt-watch" 
	;;
	*)
		echo "Invalid input! Please try again."
	;;
esac
