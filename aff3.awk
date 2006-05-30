#Skrypt przetwarza plik wygenerowany poleceniem ispell -e2, o postaci:
#wyraz/FLAGI forma1 forma2 forma3...
#do postaci:
#wyraz HT forma1 HT FLAGI HT dana_flaga HT obciecie HT koncowka HT warunki_na_rdzen_slow
#ten plik bêdzie plikiem form odmiennych, formy podstawowe s¹ pomijane (nie pamiêtam, dlaczego!)
BEGIN {FS="[ ]+"
affixfile="pl_PL.aff"; #plik afiksów
while ((getline < affixfile)  > 0){ 
	if ($5!="" && $1=="SFX") {
	if (koncowki[$2]!="") koncowki[$2]=koncowki[$2]"+++"$3"\t"$4"\t"$5;
	else koncowki[$2]=$3"\t"$4"\t"$5
	}
	if ($5!="" && $1=="PFX") {
	if (prefiksy[$2]!="") prefiksy[$2]=prefiksy[$2]"+++"$3"\t"$4"\t"$5;
	else prefiksy[$2]=$3"\t"$4"\t"$5
	}
	}

FS=" |/"
}

{
for (n=1;n<=length($2);n++)
	{
	#print $2
	flaga_biezaca=koncowki[substr($2, n, 1)]
	#print substr($2, n, 1) "->" flaga_biezaca
	if (flaga_biezaca=="" && prefiksy[substr($2, n, 1)]!="")
			{
			flaga_biezaca=prefiksy[substr($2, n, 1)]
			#print "negacja!"
			liczba=split(flaga_biezaca, tablica_prefiksow,"+++")
			#print liczba
			for (i in tablica_prefiksow)
			{
			liczba_konc=split(tablica_prefiksow[i], wpis, "\t")
			#print tablica_prefiksow[i]
			if (match($1,"\\<"wpis[3]))
			for (j=3;j<=NF;j++)
				if (match($j,"\\<"wpis[2])) print $j"\t"$1"\t"$2"\t"substr($2, n, 1)"\t"wpis[1]"\t"wpis[2]"\t"wpis[3]
			}
	}
			
	#przy ka¿dym przejœciu pêtli kolejna flaga
	liczba=split(flaga_biezaca, tablica_koncowek,"+++")
	#print liczba
	for (i in tablica_koncowek)
		{
		liczba_konc=split(tablica_koncowek[i], wpis, "\t")
		#print tablica_koncowek[i]
		if (wpis[1]!="0") rdzen=gensub(wpis[1]"\\>","",1, $1)
		else rdzen=$3
		if (match($1,wpis[3]"\\>"))
		for (j=3;j<=NF;j++)
			if (match($j,wpis[2]"\\>") &&(rdzen wpis[2]==$j)) print $j"\t"$1"\t"$2"\t"substr($2, n, 1)"\t"wpis[1]"\t"wpis[2]"\t"wpis[3]
		}
	}
}