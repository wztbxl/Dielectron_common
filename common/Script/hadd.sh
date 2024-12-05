#!/bin/bash

date 

function showhelp()
{
    cat<<EOF
=========================================================
How to Use this macro:
Example:
   ./hadd.sh runmode "SourceDir" "DestinationDir" NfilesPerJob Options
   SourceDir: Your input root file dir name(no /);
   DestinationDir: Your output file dir name(no /);
   NfilesPerJob: How many files will accumate and submit a job;
   TEST Mode: runmode = 1;
   HADD Mode: runmode = 0;
   Options : please look at hadd options. see:  hadd --help
=========================================================
EOF
}
#echo -e "\033[32m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#echo -e "\033[32m+ Version : 5.0                                                       +\033[0m"
#echo -e "\033[32m+ Author  : Long Zhou                                                 +\033[0m"
#echo -e "\033[32m+ Time    : 2015/5/22                                                 +\033[0m" 
#echo -e "\033[32m+ Describe: This macro is a standard program used to add histograms.  +\033[0m"
#echo -e "\033[32m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"

echo -e "\033[32mBefore run this code, need do some clearance . \033[0m"
if [ -d haddinfo ]
then 
    rm -rf haddinfo  
fi

if [ -e myhadd.xml ]
then
    rm -f myhadd.xml
fi 

echo -e "\033[32mClearance Done ! \033[0m"

mydir=`pwd`
myInputNumber=$#
args=('1' 'out' 'Hist' '10' '')

echo -e "\033[32mInput arguments number is $myInputNumber \033[0m"

count=0
for i in $@
do 
    args[$count]=$i
    let "count+=1"
done 

if [ "$1" = "-h" -o "$1" = "-help" -o "$1" = "--help" -o "$1" = "--h" ]
then 
    showhelp
    exit 1 
fi 

echo -e "\033[32mStart creating xml file and submit jobs ... \033[0m"

if [ ! -e "${args[1]}" ]
then 
    echo -e "\033[31mERROR: \" ${args[1]} \" No such file or directory, please check it ! \033[0m"
    showhelp
    exit 1
fi 
histdir=${args[2]}

if [ "${args[0]}" != "0" -a "${args[0]}" != "1" ]
then
    echo -e "\033[31mWrong Input Argument. \033[0m"
    showhelp
    exit 1 
fi

if [ -e "$histdir" ]
then 
    rm -f ${histdir}/*
else 
    mkdir ${histdir}
fi 

echo -e "\033[31m------------------------------------\033[0m "
echo -e "\033[31mThe Execute Arguments is :  \033[0m "

for iarg in ${args[@]}
do 
    echo -e -n "\033[31m\"${iarg}\" \033[0m"
done 

echo ""
echo -e "\033[31m------------------------------------\033[0m "

root4star -l -b -q '~/Scripts/Hadd/myhadd.cpp("'$mydir'",'${args[0]}',"'${args[1]}'","'${args[2]}'",'${args[3]}',"'${args[4]}'")'

echo -e "\033[32mSubmit Done! Please check it! \033[0m "

echo -e "\033[32mWork Done !  \033[0m "

