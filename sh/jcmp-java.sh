IFS='.' read -ra file<<<$1; IFS=''
exe=${file[0]}

javac $1
status=$?
if [[ $status == 0 ]]; then
	java $exe
	status=$?
fi
