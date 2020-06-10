#! /bin/bash
tim=$(date)
echo "start $tim" > time
original=$1
name=$2
mkdir ../fatto WIP WIP/encoding WIP/av1_encoded WIP/weighting WIP/weighted WIP/used
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
	mv weighting/"$tmp" weighted/$i$tmp
done
for crf_val in {29..29} 
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
	       aa=$(ls weighted/ | grep ${a}i )
	       mv weighted/$aa encoding/$aa
	       ffmpeg -i encoding/$aa -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${aa#$a}
	       mv encoding/$aa used/$aa
	done |
	for b in $(seq -w $count -1 8)
	do
		bb=$(ls weighted/ | grep ${b}i )
		mv weighted/$bb encoding/$bb
		ffmpeg -i encoding/$bb -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${bb#$b}
		mv encoding/$bb used/$bb
	done |
	for c in $(seq -w 1 $count)
	do
		cc=$(ls weighted/ | grep ${c}i )
		mv weighted/$cc encoding/$cc
		ffmpeg -i encoding/$cc -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${cc#$c}
		mv encoding/$cc used/$cc
	done |
	for d in $(seq -w $d1 -1 8)
	do
		dd=$(ls weighted/ | grep ${d}i )
		mv weighted/$dd encoding/$dd
		ffmpeg -i encoding/$dd -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${dd#$d}
		mv encoding/$dd used/$dd
	done |
	for e in $(seq -w 2 $count)
	do
		ee=$(ls weighted/ | grep ${e}i )
		mv weighted/$ee encoding/$ee
		ffmpeg -i encoding/$ee -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${ee#$e}
		mv encoding/$ee used/$ee
	done |
	for f in $(seq -w $f1 -1 8)
	do
		ff=$(ls weighted/ | grep ${f}i )
		mv weighted/$ff encoding/$ff
		ffmpeg -i encoding/$ff -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${ff#$f}
		mv encoding/$ff used/$ff
	done |
	for g in $(seq -w 3 $count)
	do
		gg=$(ls weighted/ | grep ${g}i )
		mv weighted/$gg encoding/$gg
		ffmpeg -i encoding/$gg -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${gg#$g}
		mv encoding/$gg used/$gg
	done |
	for h in $(seq -w $h1 -1 8)
	do
		hh=$(ls weighted/ | grep ${h}i )
		mv weighted/$hh encoding/$hh
		ffmpeg -i encoding/$hh -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${hh#$h}
		mv encoding/$hh used/$hh
	done |
	for i in $(seq -w 4 $count)
	do
		ii=$(ls weighted/ | grep ${i}i )
		mv weighted/$ii encoding/$ii
		ffmpeg -i encoding/$ii -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${ii#$i}
		mv encoding/$ii used/$ii
	done |
	for j in $(seq -w $j1 -1 8)
	do
		jj=$(ls weighted/ | grep ${j}i )
		mv weighted/$jj encoding/$jj
		ffmpeg -i encoding/$jj -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${jj#$j}
		mv encoding/$jj used/$jj
	done |
	for k in $(seq -w 5 $count)
	do
		kk=$(ls weighted/ | grep ${k}i )
		mv weighted/$kk encoding/$kk
		ffmpeg -i encoding/$kk -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${kk#$k}
		mv encoding/$kk used/$kk
	done |
	for l in $(seq -w $l1 -1 8)
	do
		ll=$(ls weighted/ | grep ${l}i )
		mv weighted/$ll encoding/$ll
		ffmpeg -i encoding/$ll -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${ll#$l}
		mv encoding/$ll used/$ll
	done |
	for m in $(seq -w 6 $count)
	do
		mm=$(ls weighted/ | grep ${m}i )
		mv weighted/$mm encoding/$mm
		ffmpeg -i encoding/$mm -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${mm#$m}
		mv encoding/$mm used/$mm
	done |
	for n in $(seq -w $n1 -1 8)
	do
		nn=$(ls weighted/ | grep ${n}i )
		mv weighted/$nn encoding/$nn
		ffmpeg -i encoding/$nn -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${nn#$n}
		mv encoding/$nn used/$nn
	done |
	for o in $(seq -w 7 $count)
	do
		oo=$(ls weighted/ | grep ${o}i )
		mv weighted/$oo encoding/$oo
		ffmpeg -i encoding/$oo -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${oo#$o}
		mv encoding/$oo used/$oo
	done |
	for p in $(seq -w $p1 -1 8)
	do
		pp=$(ls weighted/ | grep ${p}i )
		mv weighted/$pp encoding/$pp
		ffmpeg -i encoding/$pp -c:v libaom-av1 -crf $crf_val -b:v 0 -strict -2 av1_encoded/${pp#$p}
		mv encoding/$pp used/$pp
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
