#!/bin/bash

#Reminders:
#
#Add capability to recurse down the directory tree.
#
#Add capability to deal with the case, 
#where the standardized filename is identical
#to the name of an already existing file in the
#same folder.

echo "Hello $USER! Hand me a regex for filtering which filenames I should standardize:"

read namefilter

#Replace spaces with underscores:
rename 's/ /_/g' $namefilter

#Put underscores in front of Camel Case and Capslocked:
sedscript1='s/\([a-z]\)\([A-Z]\)/\1_\2/g'
sedscript2='s/\([A-Z]\{2,\}\)\([a-z]\)/\1_\2/g'

for file in ./$namefilter
do 
    mv $file $(echo $file|sed $sedscript1) 
done

for file in ./$namefilter
do 
    mv $file $(echo $file|sed $sedscript2) 
done

#Make all letters small:
rename 'y/[A-Z]/[a-z]/' $namefilter

#Remove underscores as names' first characters:
rename 's/^_//g' $namefilter

#Replace multiple underscores with a single underscore:
rename 's/[_]{2,}/_/g' $namefilter
