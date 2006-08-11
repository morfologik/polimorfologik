BEGIN {FS="\t"}
{if ($3=="") print "##Brak flagi:" $1FS$2}
!/verb:impt/ { if (slownik_form[$2FS$3]=="" && slownik_form[$2FS$3]!=$1) 
	slownik_form[$2FS$3]=$1
  else
   {if ($1!=slownik_form[$2FS$3]) 
  	print "Oboczna forma:" $1 "!=" slownik_form[$2FS$3] FS $2 FS $3
	}
}