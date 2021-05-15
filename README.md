# pdfbanquetocielsage
A script to convert pdf banque files to importable files for sage ciel (Compta)

The steps:
* Convert banque pdf file to Excel files
* Exclude the banques lines to a csv file which respect this format for the columns:
```
c1 (Date)	;c2	;c3 Date	    ;c4	;c5	(libelle)     ;c6;c7;c8;c9;c10 (debit)	 ;c11	;c12 (credit)
02/04/2020;		;01/04/2020	  ;	  ;INTERETS/FRAIS		;	 ;  ;	 ;  ;43,89         ;	  ;
09/04/2020;		;09/04/2020	  ;  	;VIR Client	      ;	 ;	;  ;  ;              ;    ;13.200,00
```
* Execute the script: 
```
./cleancsv.sh mybanque.csv | tee mybanque-formated.csv
```
