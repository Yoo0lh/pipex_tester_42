#!/bin/bash
grn=$'\e[1;32m'
red=$'\e[1;31m'
yel=$'\e[0;33m'
blu=$'\e[0;34m'
pur=$'\e[0;35m'
wit=$'\e[0;37m'
file1="../fileteste"
file2="../file3"
#test 1
echo "${yel}========================= ${pur}PIPEX TESTER ${yel}========================="
../pipex ../file "cat" "grep name" ../file3; cat ../file | grep "name" > tests/testm1 ;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm1")) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi
#sleep 0.3
#test 2
../pipex ../file "grep name" "grep -E s$" ../file3; cat ../file | grep "name" | grep -E s$ > tests/testm2;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm2")) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
#sleep 0.3
#test 3
../pipex ../file "grep name" "wc -l" ../file3; cat ../file | grep "name" | wc -l > tests/testm3;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm3")) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
#sleep 0.3
#test 4
../pipex ../file "cat" "wc -l" ../file3; cat ../file | wc -l > tests/testm4;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm4")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
#sleep 0.3
#test 5
../pipex ../file "ls -l" "wc -l" ../file3; ls -l ../ | wc -l > tests/testm5;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm5")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
