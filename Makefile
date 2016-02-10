
morfologik = lib/target/morfologik-tools-2.0.1.jar
sortopts   = --buffer-size=1G
javaopts   = -ea -Xmx1G
input      = eksport.tab

#
# Everything.
#
all: compile test
compile: eksport.tab build/polish.dict build/polish_synth.dict

#
# Fetch morfologik-tools (FSA compilers) using Apache Maven.
#
$(morfologik):
	cd lib && mvn dependency:copy-dependencies

#
# Check if the input is present.
#
eksport.tab:
	test -s eksport.tab || { echo "ERROR: eksport.tab not found."; exit 1; }

#
# Preprocess the raw input.
#
build/combined.input:
	mkdir -p build
	LANG=C sort $(sortopts) -u $(input) eksport.quickfix.tab | gawk -f awk/join_tags_reverse.awk > build/combined.input

#
# Build the stemming dictionary.
#
build/polish.dict: $(morfologik) build/combined.input build/polish.info
	cp build/combined.input build/polish.input
	java $(javaopts) -jar $(morfologik) dict_compile --format cfsa2 -i build/polish.input --overwrite
	cp build/polish.dict build/polish.dict.cfsa2
	java $(javaopts) -jar $(morfologik) dict_compile --format fsa5  -i build/polish.input --overwrite
	java $(javaopts) -jar $(morfologik) fsa_dump -i build/polish.dict -o build/polish.dump

build/polish.info: src/polish.info awk/version_script.awk
	gawk -f awk/version_script.awk src/polish.info > build/polish.info


#
# Build the synthesis dictionary.
#
build/polish_synth.dict: $(morfologik) build/polish_synth.input build/polish_synth.info
	java $(javaopts) -jar $(morfologik) dict_compile --format cfsa2 -i build/polish_synth.input --overwrite
	cp build/polish_synth.dict build/polish_synth.dict.cfsa2
	java $(javaopts) -jar $(morfologik) dict_compile --format fsa5  -i build/polish_synth.input --overwrite
	java $(javaopts) -jar $(morfologik) fsa_dump -i build/polish_synth.dict -o build/polish_synth.dump

build/polish_synth.input: build/combined.input
	gawk -f awk/combined-to-synth.awk build/combined.input > build/polish_synth.input

build/polish_synth.info: src/polish_synth.info awk/version_script.awk
	gawk -f awk/version_script.awk src/polish_synth.info > build/polish_synth.info

#
# Sanity checks.
#
.PHONY: test
test:
	cd lib && mvn test -Dpolish.dict=../build/polish.dict -Dpolish_synth.dict=../build/polish_synth.dict -Dcombined.input=../build/combined.input

#
# clean
#
.PHONY: clean
clean:
	rm -rf build
	rm -rf lib/target

