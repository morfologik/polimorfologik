#Makefile do tworzenia s³ownika morfologicznego

flags=fsa5

all: polimorfologik.txt polish.dict polish_synth.dict polish_tags.txt

#po³±czenie
polimorfologik.txt: eksport.tab brev-morfologik.txt
	sort -u eksport.tab brev-morfologik.txt | gawk -f join_tags.awk > polimorfologik.txt

polish.dict: polimorfologik.txt eksport.tab
	java -jar morfologik-tools-1.5.4-standalone.jar tab2morph -inf -i polimorfologik.txt -o pol.txt
	java -jar -Xmx700m morfologik-tools-1.5.4-standalone.jar fsa_build -i pol.txt -f $(flags) -o polish.dict

polish_tags.txt: polimorfologik.txt eksport.tab format_tags.awk
	gawk -f tags.awk polimorfologik.txt | gawk -f format_tags.awk | sort -u > polish_tags.txt

synt_in.txt: polimorfologik.txt eksport.tab
	gawk -f synteza_pl.awk polimorfologik.txt > synt.txt
	java -jar morfologik-tools-1.5.4-standalone.jar tab2morph -nw -i synt.txt -o synt_in.txt 2> /dev/null
	
polish_synth.dict: polimorfologik.txt eksport.tab synt_in.txt 
	java -jar -Xmx700m morfologik-tools-1.5.4-standalone.jar fsa_build -i synt_in.txt -f $(flags) -o polish_synth.dict 



test: polish_tags.txt slownik_regularny.txt
	gawk -f checktags.awk polish_tags.txt
	gawk -f check_fields.awk polimorfologik.txt

clean:
	rm -f polish.dict
	rm -f polish_synth.dict
	rm -f readme.txt
	rm -f readme_pl.txt	
	rm -f synt_in.txt
	rm -f synt.txt
	rm -f pol.txt

polish.info: src.polish.info version_script.awk
	gawk -f version_script.awk src.polish.info > polish.info
	
polish_synth.info: src.polish_synth.info version_script.awk
	gawk -f version_script.awk src.polish_synth.info > polish_synth.info
	
pack: morfologik.zip polish-$(flags).zip
 
morfologik.zip : polimorfologik.txt src.readme.txt src.readme_pl.txt version_script.awk
	 gawk -f version_script.awk src.readme.txt > readme.txt
	 gawk -f version_script.awk src.readme_pl.txt > readme_pl.txt
	 /cygdrive/c/Program\ Files/7-Zip/7z a -tzip morfologik.zip polimorfologik.txt readme.txt readme_pl.txt

polish-$(flags).zip: polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info polimorfologik.txt
	 /cygdrive/c/Program\ Files/7-Zip/7z a -tzip polish-fsa.zip polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info
