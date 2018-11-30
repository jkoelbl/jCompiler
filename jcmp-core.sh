version="jCompiler - version 0.1"

function get_verstype(){
	IFS='=' read -ra type<<<$1; IFS=''
	if [[ ${type[0]} == "-$2" ]]; then
		case "$2" in
		"py")	echo $1 ;;
		"cpp")	echo "-std=c++${type[1]}" ;;
		"c")	echo "-std=c${type[1]}" ;;
		*)	;;
		esac
	else
		echo ""
	fi
}

function get_filetype(){
	local file=$1
	local out="_"
	local size=${#file}
	for (( i=0; i<$size; i=i+1 )); do
		if [[ ${file:$i:1} == "." ]]; then
			out=${file:$i+1:$size-1}
			break;
		fi
	done
	echo $out
}

# 1=filename; 2=filetype; 3=version
function compile(){
	case "$2" in
	"_")	./$1 ;;
	"s")	sh/jcmp-s.sh $1 ;;
	"c")	sh/jcmp-c.sh $1 $3 ;;
	"cpp")	sh/jcmp-cpp.sh $1 $3 ;;
	"js")	node $1 ;;
	"rb")	ruby $1 ;;
	"sh")	./$1 ;;
	"exe")	./$1 ;;
	"py")	sh/jcmp-py.sh $1 $3 ;;
	"java")	sh/jcmp-java.sh $1 ;;
	*)	echo "unsupported filetype - $2" ;;
	esac
	echo ""
}

if [[ $1 == "--version" ]]; then
	echo $version
elif [[ $1 == "" ]]; then
	echo "Usage:"
	echo "       --version [version]"
	echo "       -f [filename], -v [version]"
else
	type=$(get_filetype $1)
	v=$(get_verstype $2 $type)
	echo $(compile $1 $type $v)
fi
