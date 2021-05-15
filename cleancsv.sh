#!/bin/bash

function usage(){
  echo "$0 <csvfile>"
}

if [ $# -lt 1 ];then
  usage
  exit 10
fi

FILTER_FILE=list_compte.txt
FILECSV=$1
iline=0
CURRENT_LINE=""
CURRENT_DATE=""
CURRENT_LIBELLE=""
CURRENT_MONTANT_DEBIT=""
CURRENT_MONTANT_CREDIT=""
while read line
do 
  DATE=`echo "$line"|awk -F';' '{print $1}'`
  LIBELLE=`echo "$line"|awk -F';' '{print $5}'`
  MONTANT_DEBIT=`echo "$line"|awk -F';' '{print $10}'|tr -d '.'`
  MONTANT_CREDIT=`echo "$line"|awk -F';' '{print $12}'|tr -d '.'`

  if [ ! -z $DATE ];then
    if [ ! -z $CURRENT_DATE ];then
      #echo "${CURRENT_DATE};;;${CURRENT_LIBELLE};${CURRENT_MONTANT_DEBIT};${CURRENT_MONTANT_CREDIT}"
      # Search the libelle
      FILTER_STATUS="NOT_FOUND"
      while read line_filter
      do
        filter_pattern=`echo $line_filter|awk -F';' '{print $1}'`
        filter_compte=`echo $line_filter|awk -F';' '{print $2}'`
        echo "${CURRENT_LIBELLE}"|egrep "$filter_pattern" &>/dev/null
        if [ $? -eq 0 ] ;then
          #echo "Found:$filter_pattern"
          if [ -z ${CURRENT_MONTANT_DEBIT} ];then
            echo "${CURRENT_DATE};BQ;${filter_compte};${CURRENT_LIBELLE};0;${CURRENT_MONTANT_CREDIT}"
          else
            echo "${CURRENT_DATE};BQ;${filter_compte};${CURRENT_LIBELLE};${CURRENT_MONTANT_DEBIT};0"
          fi 
          FILTER_STATUS="FOUND"
          break
        fi  
      done<$FILTER_FILE
      #echo "--->FILTER_STATUS=$FILTER_STATUS"
      if [ "$FILTER_STATUS" != "FOUND" ];then
        #echo "====================> Not found"
       if [ -z ${CURRENT_MONTANT_DEBIT} ];then
         echo "${CURRENT_DATE};BQ;471000;${CURRENT_LIBELLE};0;${CURRENT_MONTANT_CREDIT}"
       else
         echo "${CURRENT_DATE};BQ;471000;${CURRENT_LIBELLE};${CURRENT_MONTANT_DEBIT};0"
       fi 
      fi
      if [ -z ${CURRENT_MONTANT_DEBIT} ];then
        echo "${CURRENT_DATE};BQ;512100;${CURRENT_LIBELLE};${CURRENT_MONTANT_CREDIT};0"
      else
        echo "${CURRENT_DATE};BQ;512100;${CURRENT_LIBELLE};0;${CURRENT_MONTANT_DEBIT}"
      fi
    fi
    CURRENT_DATE="${DATE}"
    CURRENT_LIBELLE="${LIBELLE}"
    CURRENT_MONTANT_DEBIT="${MONTANT_DEBIT}"
    CURRENT_MONTANT_CREDIT="${MONTANT_CREDIT}"
  else
    CURRENT_LIBELLE="${CURRENT_LIBELLE} ${LIBELLE}"
  fi

  iline=$((iline+1))
done<$FILECSV
