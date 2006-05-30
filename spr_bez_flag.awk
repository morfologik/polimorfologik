BEGIN {FS="\t"
#wyrazy regularne, wygenerowane skryptem morpher.awk
glosfile="baza_nieodmiennych.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1"\t"$2]=$3;
}
}
{if (wyrazy[$1"\t"$1]!="") print $1 FS $1 FS wyrazy[$1"\t"$1]
	else print $1 FS $1 FS "indecl"
}