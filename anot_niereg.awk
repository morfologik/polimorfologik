#skrypt s³u¿y do anotowania skrótowego form nieregularnych
#na podstawie form regularnych
BEGIN {FS="\t"
#wyrazy regularne, wygenerowane skryptem morpher.awk
glosfile="slownik_regularny.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1"\t"$2]=$3;
}
}
{if (wyrazy[$3"\t"$2]!="") {
	split(wyrazy[$3"\t"$2], znaczniki, ":")
	print $1"\t"$2"\t"znaczniki[1]":irreg" }
	else  print $1 "\t" $2 "\t qub"
}