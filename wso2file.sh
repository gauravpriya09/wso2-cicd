#!/bin/bash
user=`echo $1`
paswd=`echo $2`
echo $user $paswd
/var/lib/jenkins/workspace/wso2_freestyle/tool/apictl/apictl login production -u ${user} -p ${paswd} -k
IFS='
'
if [ "$3" = "export" ]
then
for i in `cat api.config`
do
echo $i
aname=`echo $i|awk -F":" '{print $1}'`
version=`echo $i|awk -F":" '{print $2}'`
echo ${aname} ${version}
/var/lib/jenkins/workspace/wso2_freestyle/tool/apictl/apictl export-api -n ${aname} -v ${version} -e production -k
done
fi


if [ "X$3" == "Ximport" ]
then
for i in `cat api.config`
do
aname=`echo $i|awk -F":" '{print $1}'`
version=`echo $i|awk -F":" '{print $2}'`
echo ${aname} ${version}
/var/lib/jenkins/workspace/wso2_freestyle/tool/apictl/apictl import-api -f ./src/${aname}/${version}/${aname}_${version}.zip -e production -k
done
fi
