#!/bin/bash
echo Benchmarking $1 compression
if [ $1 = "mod" ]; then
	min=2
	max=9
elif [ $1 = "lzw.rb" ]; then
	min=9
	max=16
else
	echo "error with $1 command"
	exit
fi
printf "\t\t"
for size in $(seq $min $max); do
	printf "$size\t"
done
printf "\n"
for file in testFiles/* ; do
	printf "$file\t" 
	printf "$(stat --printf="%s" $file)\t"
	for size in $(seq $min $max); do
		tmpfile=$(mktemp)
		#./$1 en $size $file $tmpfile > /dev/null
		ruby $1 en $size $file $tmpfile > /dev/null
		printf "$(stat --printf="%s" $tmpfile)\t"
		tmpfile2=$(mktemp)
		#./$1 de $tmpfile $tmpfile2 > /dev/null
		ruby $1 de $tmpfile $tmpfile2 > /dev/null
		diff $file $tmpfile2	
		#echo $?
		if [ "$?" -eq 0 ]; then
			rm $tmpfile $tmpfile2
		else
			echo "error with $file $size"	
			rm $tmpfile $tmpfile2
			exit
		fi
	done
	printf "\n"
done
exit
