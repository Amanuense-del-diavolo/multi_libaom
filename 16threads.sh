#! /bin/bash



ffmpeg_looped (){
	local z="$1"
	local aa=$(ls weighted/ | grep "$z"i )
	if [ ! -z $aa ]
	then
		cd weighted
		mv "$aa" ../encoding/"$aa"
		cd ..
		yes | ffmpeg -i encoding/$aa -c:v libaom-av1 -crf "$crf_val" -minrate 500k -b:v 2000k -maxrate 2500k -pass 1 -passlogfile log"$aa" -strict -2 -an -f matroska /dev/null 2> ../log_ffmpeg/log-${aa#$z}
		ffmpeg -i encoding/"$aa" -c:v libaom-av1 -crf "$crf_val" -minrate 500k -b:v 2000k -maxrate 2500k -pass 2 -passlogfile log"$aa" -strict -2 av1_encoded/${aa#$z} 2> ../log_ffmpeg/log-${aa#$z}
		cd encoding
		mv "$aa" ../used/"$aa"
		cd ../
#		rm log"$aa""-0".log
	fi
}



tim=$(date)
echo "start $tim" > time
original="$1"
name="$2"
echo name→$name original→$original
mkdir ../fatto WIP WIP/encoding WIP/av1_encoded WIP/weighting WIP/weighted WIP/used log_ffmpeg
count=$(ffprobe -show_frames "$original" | grep -c pict_type=I)
num=${#count} 
count=$((count-=1))
ffmpeg -i "$original" -map 0:v -f segment -segment_time 0 -c:v copy -reset_timestamps 1 WIP/i%${num}d.mkv -y
ffmpeg -i "$original" -map 0:a -map 0:s -c copy WIP/other.mkv -y
count=-1
cd WIP
for i in i*
do
       	count=$((count+=1))
	mv "$i" weighting/"$i"
done
for i in $(seq -w 0 $count)
do
	tmp=$(ls -S weighting/ | head -1)
	mv weighting/"$tmp" weighted/"$i""$tmp"
done
for crf_val in {27..30} 
do 
	tmp=$count
	d1=$((tmp-=1))
	f1=$((tmp-=1))
	h1=$((tmp-=1))
	j1=$((tmp-=1))
	l1=$((tmp-=1))
	n1=$((tmp-=1))
	p1=$((tmp-=1))
	(
	for a in $(seq -w 0 $count)
	do
		ffmpeg_looped "$a"
	done |
	for b in $(seq -w $count -1 8)
	do
		ffmpeg_looped "$b"
	done |
	for c in $(seq -w 1 $count)
	do
		ffmpeg_looped "$c"
	done |
	for d in $(seq -w $d1 -1 8)
	do
		ffmpeg_looped "$d"
	done |
	for e in $(seq -w 2 $count)
	do
		ffmpeg_looped "$e"
	done |
	for f in $(seq -w $f1 -1 8)
	do
		ffmpeg_looped "$f"
	done |
	for g in $(seq -w 3 $count)
	do
		ffmpeg_looped "$g"
	done |
	for h in $(seq -w $h1 -1 8)
	do
		ffmpeg_looped "$h"
	done |
	for i in $(seq -w 4 $count)
	do
		ffmpeg_looped "$i"
	done |
	for j in $(seq -w $j1 -1 8)
	do
		ffmpeg_looped "$j"
	done |
	for k in $(seq -w 5 $count)
	do
		ffmpeg_looped "$k"
	done |
	for l in $(seq -w $l1 -1 8)
	do
		ffmpeg_looped "$l"
	done |
	for m in $(seq -w 6 $count)
	do
		ffmpeg_looped "$m"
	done |
	for n in $(seq -w $n1 -1 8)
	do
		ffmpeg_looped "$n"
	done |
	for o in $(seq -w 7 $count)
	do
		ffmpeg_looped "$o"
	done |
	for p in $(seq -w $p1 -1 8)
	do
		ffmpeg_looped "$p"
	done
	)
	cd av1_encoded
	for a in ./*.mkv
	do
		echo "file '$a'" >> mylist.txt
	done
	cd ../../
	ffmpeg -f concat -safe 0 -i WIP/av1_encoded/mylist.txt -i WIP/other.mkv -map 0:v -map 1 -c copy $name$crf_val.mkv
	tim=$(date)
	echo "end_$crf_val $tim" >> time 
	mv $name$crf_val.mkv ../fatto/
	rm -rf WIP/av1_encoded/* WIP/audio.mka
	mv WIP/used/* WIP/weighted/ 
	cd WIP
done

