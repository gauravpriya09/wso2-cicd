#!/bin/bash
user=`echo $1`
paswd=`echo $2`
echo $user $paswd
./apictl login production -u ${user} -p ${paswd} -k
IFS='
'
for i in `cat api.config`
do
aname=`echo $i|awk -F":" '{print $1}'`
version=`echo $i|awk -F":" '{print $2}`
echo ${aname} ${version}
./apictl export-api -n ${aname} -v ${version} -e production -k
done
