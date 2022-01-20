#!/bin/bash
grn=$'\e[1;32m'
red=$'\e[1;31m'
yel=$'\e[0;33m'
blu=$'\e[0;34m'
pur=$'\e[0;35m'
wit=$'\e[0;37m'
gre_2=$'\e[38;5;35m'
file1="../fileteste"
file2="../file3"

echo "${yel}========================= ${pur}PIPEX TESTER ${yel}========================="
mandatory () {
#test 1
echo "${gre_2}mandatory part :"
make fclean -C ../ 1> /dev/null
make -C ../ 1> /dev/null
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
../pipex ../file "grep name" "sort" ../file3; cat ../file | grep "name" | sort > tests/testm3;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm3")) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
#sleep 0.3
#test 4
../pipex ../file "grep -i s" "wc -l" ../file3; cat ../file | grep -i s | wc -l > tests/testm4;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm4")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
#sleep 0.3
#test 5
../pipex ../file "ls -l ../" "wc -l" ../file3; ls -l ../ | wc -l > tests/testm5;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testm5")) ]] ; then
	echo "${red}5. KO${yel}"
else
	echo "${grn}5. OK${yel}"
fi
}
bonus () {
echo "${gre_2}bonus part multiple pipes :"
make fclean -C ../ 1> /dev/null
make bonus -C ../ 1> /dev/null
#test 1
../pipex ../file "cat" "grep name" "grep -E s$" "wc -l" ../file3; cat ../file | grep name | grep -E s$ | wc -l > tests/testb1;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testb1")) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi 
../pipex ../file "cat" "grep name" "grep -E s$" ../file3; cat ../file | grep name | grep -E s$  > tests/testb2;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testb2")) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
../pipex ../file "cat" "grep -v a" "grep -E s$" ../file3; cat ../file | grep -v a | grep -E s$ > tests/testb3; 
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testb3")) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
../pipex ../file "cat" "grep -i s" "sort" "head -n 3" "uniq" "tail -5" "wc -l" ../file3; cat ../file | grep -i s | sort | head -n 3 | uniq |tail -5 | wc -l > tests/testb4;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testb4")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
../pipex ../file "cat" "grep -i s" "head -n 3" "sort"  "uniq" "tail -5" ../file3; cat ../file | grep -i s | head -n 3 | sort | uniq |tail -5  > tests/testb5;
if [[ $(diff --brief <(sort "$file2") <(sort "tests/testb5")) ]] ; then
	echo "${red}5. KO${yel}"
else
	echo "${grn}5. OK${yel}"
fi
}
if [ "$1" == "a" ]; then
	mandatory
	bonus
fi
if [ "$1" == "m" ]; then
	mandatory
fi
if [ "$1" == "b" ]; then
	bonus
fi
echo "${yel}============================== ${pur}END ${yel}============================="
