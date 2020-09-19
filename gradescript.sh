#!/bin/bash

#user input variable 
hwFolder=${1?Error: no hwfolder given}
function combine_files {
	

	for studentFolder in $hwFolder/*
	do
		local NAMEPATH=$(cut -d"/" -f 2 <<< $studentFolder)
		for f in $studentFolder/*.sql
		do
			#run sql files individually in case of missing semi colons
			(cat $f | mysql -u root -p$PASSWORD -t) > ${f%???}txt

			#concat queries 
			cat $f  >> ./CH3-queries/${NAMEPATH}_query.txt
			sed -i '' -e '$a\' ./CH3-queries/${NAMEPATH}_query.sql
			
		done
		echo $studentFolder
		cat $studentFolder/*.txt >> ./CH3-Results/${NAMEPATH}_output.txt
	done
}

read -s -p "Enter MySQL Password: " PASSWORD
combine_files