#!/bin/bash

#This while loop prints numbers incrementing by 1 until the value of the
#loop control variable, counter, is equal to 4, starting at 1. So, this
#will print 1, 2, 3, and 4 and the loop terminates.

#I find this loop interesting in that in bash, -lt is the conditional to
#indicate less than, and that even though the condition set is less than
#4, it will still print 4, even though 4 is equal to and not less than the
#condition set.

counter=0
while [ $counter -lt 4 ]; do
	let counter+=1
	echo $counter
done
