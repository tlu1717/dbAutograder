#!/bin/bash

#user input variable 
hwFolder=${1?Error: no hwfolder given}
function combine_files {
	

	for studentFolder in $hwFolder/*
	do
		local NAMEPATH=$(cut -d"/" -f 2 <<< $studentFolder)
		for f in `ls $studentFolder/*.sql | sort -g`
		do
			#run sql files individually in case of missing semi colons
			(cat $f | mysql -u root -p$PASSWORD -t) > ${f%???}txt

			#concat queries 
			#cat $f  >> ./${NAMEPATH}_query.txt
			#sed -i '' -e '$a\' ./${NAMEPATH}_query.sql
			
		done
		echo $studentFolder
		cat $studentFolder/*.txt >> ./${NAMEPATH}_output.txt
	done
}

read -s -p "Enter MySQL Password: " PASSWORD
combine_files