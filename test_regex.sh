[[ `git log -1` =~ commit\ +([^[:space:]]*) ]]
commit=${BASH_REMATCH[1]}
commit=`git log -1 --format='%H'`

if [[ $title =~ "release" ]] || [[ $title =~ "pre-release" ]];then echo "::info Not_Release";echo exit=true >> $GITHUB_ENV;fi
if [[ $title =~ pre-release ]] ;then echo pre=true >> $GITHUB_ENV;else echo pre=false >> $GITHUB_ENV ;fi