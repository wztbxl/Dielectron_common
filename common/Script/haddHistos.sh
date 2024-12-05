#!/bin/bash
date

function showhelp()
{
    cat<<EOF
=========================================================
How to Use this macro:
Example:
   ./haddHistos.sh "SourceDir" "DestinationDir" NfilesPerJob Options
   SourceDir: Your input root file dir name(no /);
   DestinationDir: Your output file dir name(no /);
   NfilesPerJob: How many files will accumate and submit a job;
   TEST Mode: runmode = 1;
   HADD Mode: runmode = 0;
   Options : please look at hadd options. see:  hadd --help
=========================================================
EOF
}

 if [ $# -ne 3 ]; then
    showhelp
    exit 0
 fi

 origDir=$1
 echo ${origDir}

 #outDir="output/Cen${1}/"
 outDir=$2

 echo "SourceDir: ${origDir}"
 echo "DestinationDir: ${outDir}"
 cd ${origDir}
 mkdir -p raw
 mkdir -p output
 mv *.root raw/

 ~/Scripts/Hadd/hadd.sh 0 raw output 50
 
