#!/bin/bash

### mpv-yt-watch ###
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
# - A very special thanks to: another-danny for improving upon the script. Video res formats are now much better and streamlined. He also added some good bash code hygiene practices I was unfamiliar with.
# - Added native yt-dlp --get-title and --get-filename flags, fully fixing any complications with video titles. $ [] and other symbols. Even languages, will now no longer affect outputs. This band-aid, I have noticed slightly more latency towards the start and end of the script but honestly, it's much better than trying to develop my own messy symbol parser.
# - Performing sanitization on my inputs, printf to replace echos, read's are now strictly for limiting inputs i.e. -nX (x being how many characters I allow)

printf "Input search string [Song | Music Artist | Youtuber]: "
read -rn1 -- search
if [[ -z "$search" ]]; then
  printf "Invalid input! Please try again!"
  exit 1;
else
  printf "You are searching for: $search"
  
  videoUrl=$(yt-dlp --get-id ytsearch1:"$search")
  videoUrl="https://youtube.com/watch?v=$videoUrl"
  
  title=$(yt-dlp --get-title "$videoUrl")
  printf "Video located: $title"
  searchFormat=$(yt-dlp ytsearch1:"$videoUrl" --list-formats)

  formatExt=$(printf "${searchFormat}" | grep -e 'webm\|mp4' | grep -v 'audio only' | awk '{print $2;}' | sort -u | nl)
  printf "$formatExt"
  printf "Choose extension format (Default: empty) [1-2]: " 
  read -rn1 -- formatExt
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

  formattedSearch=$(printf "${searchFormat}" | grep -e '144p\|240p\|480p\|720p\|1080p\|1440p\|2160p' | awk '{print $14;}' | tr -s '\n' | tr -d ',' | uniq)

  formattedLine=$(printf "$formattedSearch" | sed -e :a -e '$!N; s/\n/ | /; ta' | sed -e 's/p60//g' | sed -e 's/p//g')
  printf "${formattedSearch[@]}"$'\n'"Choose video resolution format (Default: best) [${formattedLine}]: " 
  read -rn4 -- formatRes
  formatRes=${formatRes:-$(printf "${formattedSearch[@]}" | sort -t p -n -k 1 | tail -1 | sed -e 's/p//g')}

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

  printf "Would you like to save a copy of this video: $title? [y/N]: " 
  read -rn1 -- dlConfirm
  dlConfirm=${dlConfirm:-N}

  case $dlConfirm in
	y|Y)
		echo "Downloading file" 
		videoDl=$(yt-dlp "$videoUrl")
		result=$(yt-dlp --get-filename "$videoUrl")
		printf "Your video has been saved as: $result"
		printf "Now Streaming: $title"
		mpv --ytdl-format="bestvideo$ext[height=$formatRes]+bestaudio" "$videoUrl"
		printf "Thank you for using mpv-yt-watch" 
	;;
	n|N)
		mpv --ytdl-format="bestvideo$ext[height=$formatRes]+bestaudio" "$videoUrl"
		printf "Thank you for using mpv-yt-watch" 
	;;
	*)
		printf "Invalid input! Please try again."
	;;
  esac
fi
