#!/bin/bash

### mpv-yt-watch.sh ###
# - Added search string functionality, now you no longer need a browser at all really
# - Need for url validation no longer required
# - Removed unnecessary usage of caching to stdoutput and stderr
# - Addition of 240p resolution option
# - Change over from search variable grep to cache variable grep, allowing for all language support (korean, japanese etc.) [may require wqy-zenhei on arch linux]
# - Replaced relevant echoes and reads with just reads, simplifying the code by a few lines

read -p "Input search string <lowercase only>: " search
echo "You are searching for: $search"
if [[ -z "$search" ]]; then
  echo "No search string inputted"
else
  read -p "Would you like to change the resolution? (default is dependent on video) [Y/n]: " resConfirm
  if [[ "$resConfirm" == [Yy] ]]; then
    echo -e "Available Resolutions: "
    resInput=$(yt-dlp ytsearch1:"$search" --list-formats | grep -e '240p\|480p\|720p\|1080p\|1440p\|2160p' | awk '{print $14;}' | tr -d 'p,' | tr -s '\n' | uniq | nl)
    echo "$resInput"
    read -p "Choose resolution [1|2|3|4|5|6]: " resInput
    case $resInput in
    "1")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    result=$(ls | grep -i "$cache")
	    echo "search: $search"
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=240]+bestaudio[ext=webm]" 
    ;;
    "2")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    result=$(ls | grep -i "$cache")
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=480]+bestaudio[ext=webm]"
    ;;
    "3")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    echo "$search"
	    result=$(ls | grep -i "$cache")
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=720]+bestaudio[ext=webm]" 
    ;;
    "4")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    result=$(ls | grep -i "$cache")
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=1080]+bestaudio[ext=webm]"

    ;;
    "5")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    result=$(ls | grep -i "$cache")
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=1440]+bestaudio[ext=webm]" 
    ;;
    "6")
	    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
	    echo "cache: $cache"
	    result=$(ls | grep -i "$cache")
	    echo "result: $result"
	    mpv "$result" --ytdl-format="bestvideo[ext=webm][height=2160]+bestaudio[ext=webm]" 
    ;;
    *)
	    echo "Please enter a valid input!"
    esac
  elif [[ "$resConfirm" == [A-za-Z] ]]; then
    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
    echo "cache: $cache"
    result=$(ls | grep -i "$cache")
    echo "result: $result"
    mpv "$result"
  
  else
    cache=$(yt-dlp ytsearch1:"$search" | grep "Destination" | tail -n 1 | sed 's/\[download] Destination: //g' | sed 's/.\{23\}$//')
    echo "cache: $cache"
    result=$(ls | grep -i "$cache")
    echo "result: $result"
    mpv "$result"
  fi
fi
