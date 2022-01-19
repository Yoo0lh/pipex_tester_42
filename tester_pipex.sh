#!/bin/bash
grn=$'\e[1;32m'
red=$'\e[1;31m'
file1="fileteste"
file2="file3"
#test 1
./pipex file "cat" "grep name" file3; cat file | grep "name" > fileteste;
if [[ $(diff --brief <(sort "$file1") <(sort "$file2")) ]] ; then
	echo "${red}KO"
else
	echo "${grn}OK"
fi
#sleep 0.5
#test 2
./pipex file "grep name" "grep -E s$" file3; cat file | grep "name" | grep -E s$ > fileteste;
if [[ $(diff --brief <(sort "$file1") <(sort "$file2")) ]] ; then
	echo "${red}KO"
else
	echo "${grn}OK"
fi
#test 3
./pipex file "grep name" "wc -l" file3; cat file | grep "name" | wc -l > fileteste;
if [[ $(diff --brief <(sort "$file1") <(sort "$file2")) ]] ; then
	echo "${red}KO"
else
	echo "${grn}OK"
fi
./pipex file "cat" "wc -l" file3; cat file | wc -l > fileteste;
if [[ $(diff --brief <(sort "$file1") <(sort "$file2")) ]] ; then
	echo "${red}KO"
else
	echo "${grn}OK"
fi
