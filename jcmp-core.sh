version="jCompiler - version 0.0"
function get_filetype(){
	local file=$1
	local out=""
	local size=${#file}
	for (( i=0; i<$size; i=i+1 )); do
		if [[ ${file[0]} == "." ]]; then
			out=${file:$i+1:$size-1}
			break;
		fi
	done
	return out
}

# 1=filename; 2=filetype; 3=version
function compile(){
	case "$2" in
	"js")	node $1
	"rb")	ruby $1
	"sh")	./$1
	"exe")	./$1
	"")	./$1
	"py")	jcmp/sh/jcmp-py.sh $1 $3 ;;
	"java")	jcmp/sh/jcmp-java.sh $1 ;;
	"cpp")	jcmp/sh/jcmp-cpp.sh $1 $3 ;;
	"c")	jcmp/sh/jcmp-c.sh $1 $3 ;;
	"asm")	jcompiler/sh/jcmp-s.sh $1 ;;
	*)	echo "unsupported filetype - $2" ;;
	esac
	echo ""
}

if [[ $1 == "--version" ]]; then
	echo $version
elif
	echo "Usage:"
	echo "       --version [version]"
	echo "       -f [filename], -v [version]"
else
	type=$(get_filetype $1)
	echo $(compile $1 $type $2)
fi
