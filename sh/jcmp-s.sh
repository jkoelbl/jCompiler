#!/bin/bash

has_run=false
IFS='.' read -ra file<<<$1; IFS=''
bin="${file[0]}.o"
exe=${file[0]}

as -o $bin $1
status=$?
if [[ $status == 0 ]]; then
	ld -o $exe $bin
	status=$?
	if [[ $status == 0 ]]; then
		has_run=true
		./$exe
		status=$?
	fi
fi
