#!/bin/bash

DIR=data/
SEQ=$1 #sequence fasta
XML=$2      # xml with regions data
OUT_ID=$3   #output id
MIN=$4      #min nucleotides value

function utr5 {
  echo "5'UTR"
}

function utr3 {
  echo $XML $OUT_ID $MIN 
  perl XMLparser.pl $XML $DIR/${OUT_ID}_ids.txt $MIN

  perl get_3UTR.pl $SEQ $DIR/utr3_384.txt $DIR/${OUT_ID}_3UTR.fa
  echo done
  exit
}



echo "Select genome region"
OPTIONS="5'UTR 3'UTR exit"
           select opt in $OPTIONS; do 
               if [ "$opt" = "5'UTR" ]; then
                utr5
               elif [ "$opt" = "3'UTR" ]; then
                utr3  
               elif [ "$opt" = "exit" ]; then
                echo done
                exit
               else
                clear
                echo bad option
               fi
           done