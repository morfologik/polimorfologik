#Makefile do tworzenia s³ownika morfologicznego
#pliki:
#afiksy - plik ze specyfikacj¹, która flaga ispella odpowiada za okreœlony wyraz
#formy.txt - plik s³ownika: wyraz - flagi i koñcówki ispella
#odm.txt - aktualny s³ownik z witryny www.kurnik.pl/slownik (s³ownik odmian)
#pl_PL.aff - aktualny plik ze s³ownika myspell z witryny kurnik.pl
#pojedyncze.txt - wyrazy nieodmienne
#nieregularne.txt - odmiany nieregularne
#slownik_regularny - s³ownik morfologiczny odmian regularnych, generowany
#morfo_baza.txt - baza morfologiczna (odwzorowanie flagi i koñcówki ispella -> oznaczenia morfosyntaktyczne)
#baza_nieodmiennych.txt - wyrazy z rêcznie dobranymi anotacjami
#polish.all - ze s³ownika alternatywnego
#build - ze s³ownika alternatywnego

formy formy.txt formy_pdst.txt: polish.all
	gawk -f aff5.awk polish.all >formy.txt
	gawk -f forma_pdst.awk polish.all >formy_pdst.txt 
lacz formy_ost.txt: formy.txt formy_pdst.txt
	cat formy.txt formy_pdst.txt | sort -u > formy_ost.txt
slownik:
#slownik regularny
	gawk -f morpher.awk formy_ost.txt >slownik_regularny.txt
#przygotowanie form nieregularnych 
	gawk -f nietypowe.awk polish.all >bez_flag.txt
	gawk -f dopisane.awk odm.txt >nieregularne.txt
anot slownik_niereg.txt: nieregularne.txt slownik_regularny.txt
	gawk -f anot_niereg.awk nieregularne.txt > slownik_niereg.txt

join morfologik.txt: slownik_niereg.txt slownik_nieregularny.txt slownik_regularny.txt
#po³¹czenie
	cat slownik*.txt | gawk -f anot_all.awk | sort -u > morfologik.txt

fsa:
	gawk -f ../fsa/morph_infix.awk morfologik.txt | sort -u |fsa_build -O -o polish.dict

synteza polish_synth.dict: morfologik.txt
	gawk -f tags.awk morfologik.txt | gawk -f format_tags.awk | sort -u > polish_tags.txt
	gawk -f synteza_pl.awk morfologik.txt |gawk -f morph_data.awk | sort -u |fsa_build -O -o polish_synth.dict
	
all: formy lacz slownik anot join fsa synteza

test:
#formy_ht_3.txt - plik testowy
#	gawk -f compare.awk formy_ht_3.txt >konflikty.txt
	grep "##" slownik_regularny.txt >raport.txt
#	gawk -f test_oboczne.awk slownik_regularny.txt >>raport.txt

clean:
	rm formy*.txt
	rm bez_flag.txt
	rm slownik*.txt
	rm nieregularne.txt
	rm afiksy.txt
	
pack morfologik.zip polish-fsa.zip: morfologik.txt polish.dict polish_synth.dict readme.txt
	7za a -tzip morfologik.zip morfologik.txt readme.txt
	7za a -tzip polish-fsa.zip polish.dict polish_synth.dict readme.txt