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

/\//{
for (n=1;n<=length($2);n++)
	{
	#print $2
	flaga_biezaca=koncowki[substr($2, n, 1)]
	#print substr($2, n, 1) "->" flaga_biezaca
	if (flaga_biezaca=="" && prefiksy[substr($2, n, 1)]!="")
			{
			flaga_negacji=prefiksy[substr($2, n, 1)]
			#print "negacja!"
			liczba=split(flaga_negacji, tablica_prefiksow,"+++")
			#print liczba
			for (i in tablica_prefiksow)
			{
			liczba_konc=split(tablica_prefiksow[i], wpis_pref, "\t")
			#removing "0"
			if (wpis_pref[2]=="0") wpis_pref[2]=""
			#print tablica_prefiksow[i]
			if (match($1,"\\<"wpis_pref[3]))
			{
			#dla ka¿dej koñcówki trzeba to sprawdziæ
			flagi_wszystkie=$2;
			split(flagi_wszystkie, flagi_nienegacji,"");
			podstaw=0
			for (l in flagi_nienegacji)
			{
			flaga_new=koncowki[flagi_nienegacji[l]]
			liczba=split(flaga_new, tablica_koncowek,"+++")
			for (dd in tablica_koncowek)
			{
			liczba_konc=split(tablica_koncowek[dd], wpis, "\t")
			if (wpis[2]=="0") wpis[2]=""
			if (wpis[1]!="0") rdzen = gensub("__END_","","g",gensub(wpis[1]"__END_","",1, $1"__END_")) #gensub(wpis[1]"\\>","",1, $1)
				else rdzen = $3			
			#if (match($1,wpis[3]"\\>"))
			if ($1"__END_"~wpis[3]"__END_")
			for (j=4;j<=NF;j++)
				if ($j==wpis_pref[2] rdzen wpis[2]) 
					print $j"\t"$1"\t"$2"\t"substr($2, n, 1)flagi_nienegacji[l]"\t"wpis[1]"\t"wpis[2]"\t"wpis[3]
				else
					if (podstaw==0) 
					if ($j ==wpis_pref[2] rdzen) {#forma podstawowa z negacja
					print $j"\t"$1"\t"$2"\t"$2"!\t0\t0\t"
					podstaw=1
					}
			}
			}
			}
			}
	}
			
	#przy ka¿dym przejœciu pêtli kolejna flaga
	liczba=split(flaga_biezaca, tablica_koncowek,"+++")
	#print liczba
	for (i in tablica_koncowek)
		{
		liczba_konc=split(tablica_koncowek[i], wpis, "\t")
		if (wpis[2]=="0") wpis[2]=""
		#print tablica_koncowek[i]
		if (wpis[1]!="0") rdzen=gensub("__END_","","g",gensub(wpis[1]"__END_","",1, $1"__END_")) #gensub(wpis[1]"\\>","",1, $1)
		else rdzen=$3
		#if (($1"__END_"~wpis[3]"__END_")!=($1~wpis[3]"\\>")) print "niedobrze" wpis[3] "--" $1
		#if (wpis[1]!="0" && gensub(wpis[1]"\\>","",1, $1) !=gensub("__END_","","g",gensub(wpis[1]"__END_","",1, $1"__END_"))) {
		#	stem=$1"__END_"
		#	print wpis[1]
		#	tst_str="/"wpis[1]"__END_/"
		#	print tst_str
		#	print "temat1" gensub("__END_","","g",gensub(tst_str,"",1, stem))
		#	print "temat2" gensub(wpis[1]"\\>","",1, $1) }
		#if ($1=="abatysa") print "--" rdzen
		#if (match($1,wpis[3]"\\>"))
		if ($1"__END_"~wpis[3]"__END_")
		for (j=4;j<=NF;j++)			
			if (rdzen wpis[2]==$j) print $j"\t"$1"\t"$2"\t"substr($2, n, 1)"\t"wpis[1]"\t"wpis[2]"\t"wpis[3]
			
		}
	}
}