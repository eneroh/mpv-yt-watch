#!/usr/bin/env bash

### mpv-yt-watch ###

set -euo pipefail


printf "Input search string [Song | Music Artist | Youtuber]: "
read -r -- search

if [[ -z "$search" ]]; then
  printf "Invalid input! Please try again."
  exit 1;
else
  printf "%s" "You are searching for: $search"
  
  videoUrl=$(yt-dlp --get-id ytsearch1:"$search")
  videoUrl="https://youtube.com/watch?v=$videoUrl"
  
  title=$(yt-dlp --get-title "$videoUrl")

  printf "%b" "\nVideo located: $title\n"
  searchFormat=$(yt-dlp ytsearch1:"$videoUrl" --list-formats)

  formatExt=$(printf "%s" "${searchFormat}" | grep --regexp 'webm\|mp4' | grep --invert-match 'audio only' | awk '{print $2;}' | sort --unique | nl)
  printf "%s" "$formatExt"
  lineCountFE=$(printf "%b" "$formatExt\n" | wc --lines)
  printf "%b" "\nChoose extension format (Default: webm) [1-$lineCountFE]: "
  read -rn1 -- formatExt
  
  case $formatExt in
    1)  ext=mp4  ;;
    2)  ext=webm  ;;
    *)  ext=webm  ;;
  esac
  
  formatRes=$(printf "%s" "${searchFormat}" | grep --regexp '144p\|240p\|480p\|720p\|1080p\|1440p\|2160p' | awk '{print $14;}' | uniq | nl)
  formatRes="${formatRes//\,/}"
  printf "%b" "\n$formatRes\n"
  lineCountFR=$(printf "%b" "$formatRes\n" | wc --lines)
  printf "%s" "Choose video resolution format [1-$lineCountFR]: "
  read -rn1 -- formatRes

  case $formatRes in
    1)  h=144  ;;
    2)  h=240  ;;
    3)  h=480  ;;
    4)  h=720  ;;
    5)  h=1080  ;;
    6)  h=1440  ;;
    7)  h=2160  ;;
    *)  
      printf "Invalid Input, please try again". 
      exit 1;
    ;;
  esac

  printf "%b" "\nWould you like to save a copy of this video: $title? [y/N]: "
  read -rn1 -- dlConfirm
  dlConfirm=${dlConfirm:-N}

  case $dlConfirm in
    y|Y)
      printf "\nDownloading file\n" 
      videoDl=$(yt-dlp "$videoUrl" | tail --lines=1)
      printf "%s" "$videoDl"
      result=$(yt-dlp --get-filename "$videoUrl")
      printf "%b" "\nYour video has been saved as: $result"
      printf "%b" "\nNow Streaming: $title\n"
      notify-send "mpv-yt-watch" "Now Streaming: $title"
      mpv --ytdl-format="bestvideo[ext=$ext][height=$h]+bestaudio" "$videoUrl"
      printf "Thank you for using mpv-yt-watch".
    ;;
    n|N)
      printf "%b" "\nNow Streaming: $title\n"
      notify-send "mpv-yt-watch" "Now Streaming: $title"
      mpv --ytdl-format="bestvideo[ext=$ext][height=$h]+bestaudio" "$videoUrl"
      printf "Thank you for using mpv-yt-watch". 
    ;;
    *)
      printf "Invalid input! Please try again".
      exit 1;
    ;;
  esac
fi
