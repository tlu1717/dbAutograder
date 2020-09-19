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
			(cat $f | mysqldump --login-path=local -t) > ${f%???}txt
		done
		cat $studentFolder/*.txt >> ./$NAMEPATH.txt
	done
}

combine_files