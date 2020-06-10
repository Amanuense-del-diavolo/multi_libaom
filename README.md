# multi_libaom

this project started on early 2019 as a stupid way to multithread libaom-av1 bith some ignorant bash

the idea is simple, the script uses ffmpeg (of course it does) and splits the video at every i-frame,
than it re-encodes the parts whith half the processes going from the heaviest part to the lightiest half going the other way

it then concatenate in order all the pieces and slaps on the other than wideo streams

it's not efficent by any means, but it's somewhat faster than standard libaom-av1

when I did this i didn't know aboiut rav1e or svt-av1, i don't even think they existed back then

for now the script is "hardcoded" to use 16 threads, since that's the thread number on my machine, maybe in the future I'll do something more dinamic

bear in mind, for a bit of extra performances I'll ususally run the program in a ramdisk, to reduce I/O's

may be in the future that I'll do it with a funztion and some recursion, no promisses tho, and maybe I'll add a two pass option too

as today, i think is still the fastest way to use libaom, with a trivial change you can put rav1e or svt-av1 if you so desire

have fun with it as I did

PS: it was made in thought for linux, I don't know how it will behave on mac and surely it will not work on windows
