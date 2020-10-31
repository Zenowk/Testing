#!/bin/bash

#This until loop prints numbers decrementing by 1 until the value of the
#loop control variable, counter, is equal to 2. It starts at 11 because
#the loop decrements counter by 1 before printing the number.

#I find this loop interesting because Java doesn't have this loop, and I
#think that it performs a useful function which is the opposite of the
#while loop, by continuing to execute the block of code as long as the
#condition is false, not true.

counter=12
until [ $counter -lt 3 ]; do
	let counter-=1
	echo $counter
done
