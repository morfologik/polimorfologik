BEGIN {FS="\t"
glosfile="morfologik.txt"; #s³ownik morfologiczny
while ((getline < glosfile)  > 0){ 
	tablica[$1FS$2]=$3
	}
}
{if (index(tablica[$1FS$2],$3)<1 && tablica[$1FS$2]!="") print $1 FS $2 FS $3 FS tablica[$1FS$2]}
