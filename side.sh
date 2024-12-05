#!/bin/bash

cwd=$(cd $(dirname $0); pwd)
sidebar=$cwd/_sidebar.md
echo "" > $sidebar

# 处理一个目录
handle_dir() {
    local path=$1
    # local tt=$2
    # local ind=$2
    
    cd $path

    local ind=$(echo $path | sed "s|${cwd}||g")
    local n=$(echo $ind|grep -o / | wc -l)
    local tt=$(awk -v n="$n" 'BEGIN { for (i=0; i<n; i++) printf "\t"; }')

    echo -e "$tt 开始处理$path, ind=$ind, n=$n"

    ls -1 | while read f; do
        if [[ -d "$path/$f" && $f != _* ]]; then
            echo -e "$tt* $f" >> $sidebar
            handle_dir $path/$f 
        else
            if [[ $f != _* && $f != index.html && $f != readme.md && $f != side.sh ]]; then
                f_no_md=$(basename "$f" '.md')
                echo -e "$tt 开始处理$f"
                
                echo -e "$tt* [$f_no_md]($ind/$f)" >> $cwd/_sidebar.md 
            fi
        fi    
    done
}

handle_dir $cwd 