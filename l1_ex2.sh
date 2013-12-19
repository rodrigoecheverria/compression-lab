#!/bin/bash
rm realRates_yes
reversible=yes
for (( i=1; i<=600; i=i*2 ))
do
   dot=`echo "scale = 2; $i / 10" | bc`
   echo $dot >> realRates_$reversible
   realRate=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $dot Creversible=$reversible | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   echo "$dot,$realRate,$PSNR"
done

#Cleanup step
rm out*
