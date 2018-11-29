IFS='.' read -ra file<<<$1; IFS=''
bin="$1.o"

g++ -Wall -o $bin $1 $2
status=$?
if [[ $status == 0 ]]; then
	./$bin
	status=$?
fi

