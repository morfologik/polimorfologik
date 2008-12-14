#Makefile do tworzenia s³ownika morfologicznego

all: morfologik.txt polish.dict polish_synth.dict polish_tags.txt

formy.txt : polish.all
	gawk -f aff5.awk polish.all >formy.txt

formy_pdst.txt : polish.all	
	gawk -f forma_pdst.awk polish.all >formy_pdst.txt 

formy_ost.txt: formy.txt formy_pdst.txt
	cat formy.txt formy_pdst.txt | sort -u > formy_ost.txt


#slownik regularny
slownik_regularny.txt: formy_ost.txt morfo_baza.txt
	gawk -f morpher.awk formy_ost.txt |gawk -f correct_case.awk >slownik_regularny.txt

#przygotowanie form nieregularnych 
bez_flag.txt: polish.all
	gawk -f nietypowe.awk polish.all >bez_flag.txt

nieregularne.txt:odm.txt bez_flag.txt
	gawk -f dopisane.awk odm.txt >nieregularne.txt

slownik_niereg.txt: nieregularne.txt 
	-rm aspekt.txt
	gawk -f anot_niereg.awk nieregularne.txt > slownik_niereg.txt

#po³±czenie
morfologik.txt: slownik_regularny.txt slownik_niereg.txt slownik_nieregularny.txt
	cat slownik*.txt | gawk -f anot_all.awk | sort -u > morfologik.txt

polish.dict: morfologik.txt
	gawk -f ../fsa/morph_infix.awk morfologik.txt | sort -u |../fsa/fsa_build -O -o polish.dict

polish_tags.txt: morfologik.txt slownik_regularny.txt slownik_nieregularny.txt
	gawk -f tags.awk morfologik.txt | gawk -f format_tags.awk | sort -u > polish_tags.txt

polish_synth.dict: morfologik.txt
	gawk -f synteza_pl.awk morfologik.txt |gawk -f morph_data.awk | sort -u |fsa_build -O -o polish_synth.dict




test: polish_tags.txt slownik_regularny.txt
#formy_ht_3.txt - plik testowy
#	gawk -f compare.awk formy_ht_3.txt >konflikty.txt
	-grep "##" slownik_regularny.txt >raport.txt
#	gawk -f test_oboczne.awk slownik_regularny.txt >>raport.txt
	gawk -f checktags.awk polish_tags.txt

test_completeness: odm.txt polish.dict
	gawk -f format_for_fsa.awk odm.txt | fsa_morph -I -d polish.dict > odm-tagged.txt
	gawk -f check_tagging.awk odm-tagged.txt > test_complete.txt

clean:
	rm -f  formy*.txt
	rm -f bez_flag.txt
	rm -f slownik_regularny.txt slownik_niereg.txt
	rm -f nieregularne.txt
	rm -f afiksy.txt
	rm -f aspekt.txt
	

pack: morfologik.zip polish-fsa.zip
 
morfologik.zip : morfologik.txt readme.txt readme_pl.txt
	7za a -tzip morfologik.zip morfologik.txt readme.txt readme_pl.txt

polish-fsa.zip: polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info
	7za a -tzip polish-fsa.zip polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info

#wsteczna kompatybilnosc :)
formy: formy.txt formy_pdst.txt
lacz: formy_ost.txt
slownik: slownik_regularny.txt bez_flag.txt nieregularne.txt
anot: slownik_niereg.txt
join: morfologik.txt
fsa: polish.dict
synteza: polish_synth.dict polish_tags.txt
