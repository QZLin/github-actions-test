[[ `git log -1` =~ commit\ +([^[:space:]]*) ]]
commit=${BASH_REMATCH[1]}
commit=`git log -1 --format='%H'`