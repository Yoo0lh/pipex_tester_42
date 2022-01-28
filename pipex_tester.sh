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
output_here="pipe/here_doc_out"
path_std="test_std/test_m"
path_bon="test_std/test_b"
here_doc="test_std/here_doc"
echo "${yel}========================= ${pur}PIPEX TESTER ${yel}========================="

mandatory () {
#test 1
echo "${gre_2}mandatory part :"
make fclean -C ../ 1> /dev/null
make -C ../ 1> /dev/null
../pipex "$input" "cat" "grep name" "$output"1 &&  cat "$input" | grep "name" > "$path_std"1 ;
if [[ $(diff --brief <(sort "$output"1) <(sort "$path_std"1)) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi
sleep 0.3
#test 2
../pipex "$input" "grep -i a" "grep -E e$" "$output"2 &&  cat "$input" | grep -i a | grep -E e$ > "$path_std"2;
if [[ $(diff --brief <(sort "$output"2) <(sort "$path_std"2)) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
sleep 0.3
#test 3
../pipex "$input" "grep -i s" "sort" "$output"3 && cat "$input" | grep -i s | sort > "$path_std"3;
if [[ $(diff --brief <(sort "$output"3) <(sort "$path_std"3)) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
sleep 0.3
#test 4
../pipex "input" "grep -i s" "wc -l" "$output"4 && cat "input" | grep -i s | wc -l > "$path_std"4;
if [[ $(diff --brief <(sort "$output"4) <(sort "$path_std"4)) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
sleep 0.3
#test 5
../pipex "$input" "ls -l ../" "wc -l" "$output"5 && ls -l ../ | wc -l > "$path_std"5;
if [[ $(diff --brief <(sort "$output"5) <(sort "$path_std"5)) ]] ; then
	echo "${red}5. KO${yel}"
else
	echo "${grn}5. OK${yel}"
fi
for i in {1..5} ;do rm -f "$output"$i rm -f "$path_std"$i ; done
}
bonus () {
echo "${gre_2}bonus part multiple pipes :"
make fclean -C ../ 1> /dev/null
make bonus -C ../ 1> /dev/null
#test 1
../pipex "$input" "cat" "grep name" "grep -E a$" "wc -l" "$output_b"1 && cat "$input" | grep name | grep -E a$ | wc -l > "$path_bon"1;
if [[ $(diff --brief <(sort "$output_b"1) <(sort "$path_bon"1)) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi
sleep 0.3
#test 2
../pipex "$input" "cat" "grep -i a" "grep -E e$" "$output_b"2 && cat "$input" | grep -i a | grep -E e$  > "$path_bon"2;
if [[ $(diff --brief <(sort "$output_b"2) <(sort "$path_bon"2)) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
sleep 0.3
#test 3
../pipex "$input" "cat" "grep -v a" "grep -E s$" "$output_b"3 && cat "$input" | grep -v a | grep -E s$ > "$path_bon"3; 
if [[ $(diff --brief <(sort "$output_b"3) <(sort "$path_bon"3)) ]] ; then
	echo "${red}3. KO${yel}"
else
	echo "${grn}3. OK${yel}"
fi
sleep 0.3
#test 4
../pipex "$input" "cat" "grep -i s" "sort" "head -n 3" "uniq" "tail -5" "wc -l" "$output_b"4 && cat "$input" | grep -i s | sort | head -n 3 | uniq |tail -5 | wc -l > "$path_bon"4;
if [[ $(diff --brief <(sort "$output_b"4) <(sort "$path_bon"4)) ]] ; then
	echo "${red}4. KO${yel}"
else
	echo "${grn}4. OK${yel}"
fi
sleep 0.3
#test 5
../pipex "$input" "cat" "grep -i s" "head -n 3" "sort"  "uniq" "tail -5" "$output_b"5 && cat "$input" | grep -i s | head -n 3 | sort | uniq |tail -5  > "$path_bon"5;
if [[ $(diff --brief <(sort "$output_b"5) <(sort "$path_bon"5)) ]] ; then
	echo "${red}5. KO${yel}"
else
	echo "${grn}5. OK${yel}"
fi
for i in {1..5}; do rm -f "$output_b"$i rm -f "$path_bon"$i; done
}
here_doc(){
echo "${gre_2}bonus part here_doc :"
make fclean -C ../ 1> /dev/null
make bonus -C ../ 1> /dev/null
#test 2
( (echo "hello"; echo "emim"; echo "nice"; echo "test"; echo "my life"; echo "EOF") | ../pipex here_doc EOF "cat" "grep -i e" "$here_doc"1) > /dev/null ;
cat << EOF | grep -i e >> "$output_here"1
hello
emim
nice
test
my life
EOF
if [[ $(diff --brief <(sort "$here_doc"1) <(sort "$output_here"1)) ]] ; then
	echo "${red}1. KO${yel}"
else
	echo "${grn}1. OK${yel}"
fi
sleep 0.3
#test 2
( (echo "hello" ; echo "im not"; echo "life"; echo "EOF") | ../pipex here_doc EOF "cat" "wc -l" "$here_doc"2) > /dev/null ;
cat << EOF | wc -l >> "$output_here"2
hello
im not
life
EOF
if [[ $(diff --brief <(sort "$here_doc"2) <(sort "$output_here"2)) ]] ; then
	echo "${red}2. KO${yel}"
else
	echo "${grn}2. OK${yel}"
fi
for i in {1..2}; do rm -f "$here_doc"$i rm -f "$output_here"$i; done
}
if [ "$*" == "" ]; then echo "${red}No arguments provided"
elif [ "$1" == "a" ]; then 
	mandatory 
	bonus 
	here_doc 
elif [ "$1" == "m" ]; then mandatory 
elif [ "$1" == "b" ]; then bonus
elif [ "$1" == "h" ]; then here_doc
else echo "${red}The argumments does not exist" ; fi
echo "${yel}============================== ${pur}END ${yel}============================="
