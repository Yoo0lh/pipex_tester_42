#!/bin/bash
grn=$'\e[1;32m'
red=$'\e[1;31m'
yel=$'\e[0;33m'
blu=$'\e[0;34m'
pur=$'\e[0;35m'
wit=$'\e[0;37m'
gre_2=$'\e[38;5;35m'
input="input"
output="pipe/output_m"
output_b="pipe/output_b"

echo "${yel}========================= ${pur}PIPEX TESTER ${yel}========================="
mandatory () {
#test 1
echo "${gre_2}mandatory part :"
make fclean -C ../ 1> /dev/null
make -C ../ 1> /dev/null
../pipex "$input" "cat" "grep name" "$output"1; cat "$input" | grep "name" > tests/testm1 ;
if [[ $(diff --brief <(sort "$output"1) <(sort "tests/testm1")) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi
#sleep 0.3
#test 2
../pipex "$input" "grep name" "grep -E e$" "$output"2; cat "$input" | grep "name" | grep -E e$ > tests/testm2;
if [[ $(diff --brief <(sort "$output"2) <(sort "tests/testm2")) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
#sleep 0.3
#test 3
../pipex "$input" "grep name" "sort" "$output"3; cat "$input" | grep "name" | sort > tests/testm3;
if [[ $(diff --brief <(sort "$output"3) <(sort "tests/testm3")) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
#sleep 0.3
#test 4
../pipex "input" "grep -i s" "wc -l" "$output"4; cat "input" | grep -i s | wc -l > tests/testm4;
if [[ $(diff --brief <(sort "$output"4) <(sort "tests/testm4")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
#sleep 0.3
#test 5
../pipex "$input" "ls -l ../" "wc -l" "$output"5; ls -l ../ | wc -l > tests/testm5;
if [[ $(diff --brief <(sort "$output"5) <(sort "tests/testm5")) ]] ; then
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
../pipex "$input" "cat" "grep name" "grep -E a$" "wc -l" "$output_b"1 ; cat "$input" | grep name | grep -E a$ | wc -l > tests/testb1;
if [[ $(diff --brief <(sort "$output_b"1) <(sort "tests/testb1")) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi 
../pipex "$input" "cat" "grep name" "grep -E s$" "$output_b"2; cat "$input" | grep name | grep -E s$  > tests/testb2;
if [[ $(diff --brief <(sort "$output_b"2) <(sort "tests/testb2")) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
../pipex "$input" "cat" "grep -v a" "grep -E s$" "$output_b"3; cat "$input" | grep -v a | grep -E s$ > tests/testb3; 
if [[ $(diff --brief <(sort "$output_b"3) <(sort "tests/testb3")) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
../pipex "$input" "cat" "grep -i s" "sort" "head -n 3" "uniq" "tail -5" "wc -l" "$output_b"4; cat "$input" | grep -i s | sort | head -n 3 | uniq |tail -5 | wc -l > tests/testb4;
if [[ $(diff --brief <(sort "$output_b"4) <(sort "tests/testb4")) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
../pipex "$input" "cat" "grep -i s" "head -n 3" "sort"  "uniq" "tail -5" "$output_b"5; cat "$input" | grep -i s | head -n 3 | sort | uniq |tail -5  > tests/testb5;
if [[ $(diff --brief <(sort "$output_b"5) <(sort "tests/testb5")) ]] ; then
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
