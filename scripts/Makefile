#Makefile do tworzenia słownika morfologicznego

morfologik = morfologik-tools-1.6.0-standalone.jar

all: polimorfologik.txt polish.dict polish_synth.dict polish_tags.txt

# NOTE: get polimorfologik.txt directly from sourceforge:
# http://sourceforge.net/projects/morfologik/files,
# as described here: https://github.com/morfologik/morfologik-scripts/issues/1
polimorfologik.txt: eksport.tab brev-morfologik.txt
	sort -u eksport.tab brev-morfologik.txt | gawk -f join_tags.awk > polimorfologik.txt

pol.txt: polimorfologik.txt
	java -jar $(morfologik) tab2morph -inf -i polimorfologik.txt -o pol.txt

polish.dict: pol.txt	
	java -jar -Xmx700m $(morfologik) fsa_build -i pol.txt -f fsa5 -o polish.dict

polish_tags.txt: polimorfologik.txt eksport.tab format_tags.awk
	gawk -f tags.awk polimorfologik.txt | gawk -f format_tags.awk | sort -u > polish_tags.txt

synt_in.txt: polimorfologik.txt
	gawk -f synteza_pl.awk polimorfologik.txt > synt.txt
	java -jar $(morfologik) tab2morph -nw -i synt.txt -o synt_in.txt 2> /dev/null
	
polish_synth.dict: polimorfologik.txt synt_in.txt 
	java -jar -Xmx700m $(morfologik) fsa_build -i synt_in.txt -f fsa5 -o polish_synth.dict 

pl.dict: pol.txt
	java -jar -Xmx700m $(morfologik) fsa_build -i pol.txt -f cfsa2 -o pl.dict

pl_synt_cfsa2: polimorfologik.txt synt_in.txt 
	java -jar -Xmx700m $(morfologik) fsa_build -i synt_in.txt -f cfsa2 -o polish_synth.dict 
	
pl.info: polish.info
	cp polish.info pl.info

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
	rm -f pl.dict

polish.info: src.polish.info version_script.awk
	gawk -f version_script.awk src.polish.info > polish.info
	
polish_synth.info: src.polish_synth.info version_script.awk
	gawk -f version_script.awk src.polish_synth.info > polish_synth.info
	
pack: morfologik.zip polish-fsa.zip

readme.txt: version_script.awk src.readme.txt
	 gawk -f version_script.awk src.readme.txt > readme.txt
	 
readme_pl.txt: version_script.awk src.readme_pl.txt
	 gawk -f version_script.awk src.readme_pl.txt > readme_pl.txt
 
morfologik.zip : polimorfologik.txt readme.txt readme_pl.txt
	 /cygdrive/c/Program\ Files/7-Zip/7z a -tzip morfologik.zip polimorfologik.txt readme.txt readme_pl.txt

polish-fsa.zip: polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info polimorfologik.txt
	 /cygdrive/c/Program\ Files/7-Zip/7z a -tzip polish-fsa.zip polish.dict polish_synth.dict readme.txt readme_pl.txt polish.info polish_synth.info

pl_cfsa2: pl.dict pl.info

lt: pl.dict pl.info pl_synt_cfsa2
	cp pl.dict polish.dict
	cp pl.info polish.info
