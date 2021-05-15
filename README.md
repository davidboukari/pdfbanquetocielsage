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


## Notice
To manage the rules to find the compte use the file "list_compte.txt" add or remove regex
```
cat list_compte.txt
RETRAIT DAB;455000
VIR PRELEVEMENT GERANT;455000
VIR OBJECTWARE;411000
PRLV SEPA DGFIP;445510
PRLV SEPA DGFIP.*TVA;445510
AVIS RENT-A-CAR;401000
PAIEMENT CB;625100
PAIEMENT PSC;625100
FACTURE SGT;627000
INTERETS/FRAIS;661600
SIXT;401000
MULTIRISQUE PRO;616000
COMP SANTE;646000
```
