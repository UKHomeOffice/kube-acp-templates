#!/bin/bash

./drone-common.sh

#drone repo ls --org <service_name> > repos.txt

rm output*.txt

sort -o repos.txt repos.txt

for f in $(cat repos.txt)
do
    echo
	echo Getting info for $f
	c=(${f//\//:})
    drone build ls $f --format="{{ .Number }} {{ .Status }} {{ .Commit }} {{ .Deploy }} {{ .Ref }}" > temp.txt
    cat temp.txt \
    | grep success | grep -m 1 PROD | sed 's|^|'$f' |' \
    >> outputPROD.txt
    cat temp.txt \
    | grep success | grep -m 1 UAT  | sed 's|^|'${f}' |'\
    >> outputUAT.txt
    cat temp.txt \
    | grep success | grep -m 1 STG  | sed 's|^|'${f}' |'\
    >> outputSTG.txt
    cat temp.txt \
    | grep success | grep -v PROD | grep -v UAT | grep -m 1 "refs/heads/master" | sed 's|^|'$f' |' \
    >> outputDEV.txt
done

join -a 1 -e '-' -o '0 1.2 2.2 1.4 2.4' outputUAT.txt outputPROD.txt \
| awk '{printf "%s",$0; if ($4 == $5) print " Y"; else if ($5 == "-") print " -"; else print " N";}' > outputCOMB.txt

join -a 1 -e '-' -o '0 1.2 2.2 1.4 2.4' outputUAT.txt outputDEV.txt \
| awk '{printf "%s",$0; if ($4 == $5) print " Y"; else if ($5 == "-") print " -"; else print " N";}' > outputCOMBUAT.txt

printf "%-50s %-4s %-40s %-4s\n" "REPO" "NO." "GIT SHA" "ENV" > outputFORMAT.txt
printf "%-50s %-4s %-40s %-4s\n" "====" "===" "=======" "===" >> outputFORMAT.txt
cat outputPROD.txt outputUAT.txt outputDEV.txt | awk '{print $1,$2,$4,$5}' | xargs printf "%-50s %-4s %-40s %-4s\n" >> outputFORMAT.txt

printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" "REPO" "UAT NO." "PROD NO." "UAT GIT SHA" "PROD GIT SHA" "MATCH" > outputCOMBFORMAT.txt
printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" "====" "=======" "========" "===========" "============" "=====" >> outputCOMBFORMAT.txt
cat outputCOMB.txt | xargs printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" >> outputCOMBFORMAT.txt

printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" "REPO" "UAT NO." "DEV NO." "UAT GIT SHA" "DEV GIT SHA" "MATCH" > outputCOMBUATFORMAT.txt
printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" "====" "=======" "========" "===========" "============" "=====" >> outputCOMBUATFORMAT.txt
cat outputCOMBUAT.txt | xargs printf "%-50s %-8s %-8s %-40s %-40s %-5s\n" >> outputCOMBUATFORMAT.txt

#rm temp.txt

# Example using rest api
#	curl -s -i ${DRONE_SERVER}/api/repos/$f/builds -H "Authorization: Bearer ${DRONE_TOKEN}"  \
#    | grep "\[{" \
#    | jq --arg c "$c" --raw-output ".[] | select(.status | contains(\"success\")) | select(.deploy_to | contains(\"UAT\") or contains(\"PROD\")) | \"$c\" + \" \" + ( .number | tostring ) + \" \" + (.commit) + \" \" +  (.deploy_to)" \
