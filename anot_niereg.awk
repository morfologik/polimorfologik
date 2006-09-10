#skrypt s³u¿y do anotowania skrótowego form nieregularnych
#na podstawie form regularnych
BEGIN {FS="\t"
#wyrazy regularne, wygenerowane skryptem morpher.awk
#wczytanie trwa dosyc dlugo, ale nic dziwnego!
glosfile="slownik_regularny.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1"\t"$2]=$3;
}

glosfile="slownik_nieregularny.txt"; 
while ((getline < glosfile)  > 0){ 
	nieodm[$1"\t"$2]=$3;

}


}
{if (nieodm[$1"\t"$2]=="" && wyrazy[$1"\t"$2]=="")
	{
	if (wyrazy[$3"\t"$2]!="") {
	split(wyrazy[$3"\t"$2], znaczniki, ":")
	if ($1"__END"~/[³w]szy__END/)
		print $1"\t"$2"\tpant:perf"
	else 
		print $1"\t"$2"\t"znaczniki[1]":irreg" 
	}
	else print $1 "\t" $2 "\tqub"
	}
}