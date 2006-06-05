#program s³u¿¹cy do anotacji morfologicznej
BEGIN {FS="\t"
glosfile="baza_morfologiczna.txt"; #s³ownik anotacje ispell - anotacje morfosyntaktyczne
while ((getline < glosfile)  > 0){ 
	if (lista_obecnosci[$1FS$2FS$3FS$4FS$5]=="" ||lista_obecnosci[$1FS$2FS$3FS$4FS$5]=$6)
		lista_obecnosci[$1FS$2FS$3FS$4FS$5]=$6
	else 
		{
		split($6, anotacje, "+")
		for (n in anotacje)
		if (match(lista_obecnosci[$1FS$2FS$3FS$4FS$5], anotacje[n]))
		{sklejone++}
		else
		lista_obecnosci[$1FS$2FS$3FS$4FS$5]=lista_obecnosci[$1FS$2FS$3FS$4FS$5]"+"anotacje[n]
		}
	}
cnt=0
pl=0
}

{
if (lista_obecnosci[$3FS$4FS$5FS$6FS$7]!="")
	{print $1FS$2FS lista_obecnosci[$3FS$4FS$5FS$6FS$7]
	}
}
