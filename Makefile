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

afiksy:
	./build polish.all
	./ispell -e2 -d ./polish <polish.all >afiksy.txt
formy: formy.txt formy_pdst.txt
	gawk -f aff3.awk afiksy.txt >formy.txt
	gawk -f forma_pdst.awk polish.all >formy_pdst.txt 
lacz: formy_ost.txt
	cat formy.txt formy_pdst.txt | sort -u > formy_ost.txt
slownik:
#slownik regularny
	gawk -f morpher.awk formy_ost.txt >slownik_regularny.txt
#przygotowanie form nieregularnych 
	gawk -f nietypowe.awk polish.all >bez_flag.txt
	gawk -f dopisane.awk odm.txt >nieregularne.txt
anot:
	gawk -f anot_niereg.awk nieregularne.txt > slownik_niereg.txt
#po³¹czenie
	cat slownik*.txt | sort -u > morfologik.txt

fsa:
	gawk -f morph_data.awk morfologik.txt | fsa_ubuild -O -o polish.dict
	
all: afiksy formy lacz slownik anot fsa

test:
#formy_ht_3.txt - plik testowy
	gawk -f compare.awk formy_ht_3.txt >konflikty.txt
	grep "##" slownik_regularny.txt >raport.txt
	gawk -f test_oboczne.awk slownik_regularny.txt >>raport.txt

clean:
	rm formy*.txt
	rm bez_flag.txt
	rm slownik*.txt
	rm nieregularne.txt
	rm afiksy.txt