#!/bin/bash

#Excercice 1
for (( i=1; i<=4; i=i*2 ))
do
   requested_rate=`echo "scale = 2; $i * 0.125" | bc`

   #No tiling
   real_rate_0=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_0=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #tiling 128
   real_rate_128=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Stiles=\{128,128\}| head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_128=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #tiling 64
   real_rate_64=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Stiles=\{64,64\} | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_64=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #Outline
   echo "$requested_rate,$real_rate_0,$PSNR_0,$real_rate_128,$PSNR_128,$real_rate_64,$PSNR_64"
done

#Excercice 1 plot
for (( i=0; i<=40; i++ ))
do
   requested_rate=`echo "scale = 2; $i * 0.05" | bc`
   ##echo $requested_rate #>> realRates_$reversible
   #No tiling
   real_rate_0=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_0=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #tiling 128
   real_rate_128=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Stiles=\{128,128\}| head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_128=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #tiling 64
   real_rate_64=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Stiles=\{64,64\} | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_64=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #Outline
   echo "$requested_rate,$real_rate_0,$PSNR_0,$real_rate_128,$PSNR_128,$real_rate_64,$PSNR_64"
done

#Excercice 2 plot
for (( i=0; i<=40; i++ ))
do
   requested_rate=`echo "scale = 2; $i * 0.05" | bc`
   ##echo $requested_rate #>> realRates_$reversible
   #S-9,7
   real_rate_0=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Ckernel=W9X7 Clayers=1 | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_0=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #P6-9,7
   real_rate_1=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Ckernel=W9X7 Clayers=6 | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_1=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #P7-3,5
   real_rate_2=`kdu_compress -i n5_GRAY.pgm -o out.jp2 -rate $requested_rate Ckernel=W3X5 Clayers=7 | head -n 8 | tail -n 1 | sed -e "s/[[:space:]]//g"`
   kdu_expand -i out.jp2 -o out.pgm >> /dev/null 
   PSNR_2=`Gcomp/Gcomp -i1 n5_GRAY.pgm -i2 out.pgm -m 7 | tail -n 1`
   
   #Outline
   echo "$requested_rate,$real_rate_0,$PSNR_0,$real_rate_1,$PSNR_1,$real_rate_2,$PSNR_2"
done

#Cleanup step
rm out*
