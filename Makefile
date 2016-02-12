
version_number = 2.1
version        = $(version_number) PoliMorf
release_date   = $(shell date --rfc-3339=seconds)
copyright_date = $(shell date +%Y)
githash        = $(shell git log --pretty=format:'%h' -n 1)

morfologik     = lib/target/morfologik-tools-2.0.1.jar
sortopts       = --buffer-size=1G
javaopts       = -ea -Xmx1G
input          = eksport.tab

#
# Aggregate targets.
#
all: compile \
     compile-fsamorph \
     build/polish_tags.txt \
     test \
     zip

compile: eksport.tab \
         build/polish.dict \
         build/polish_synth.dict

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
	@echo "### Building CFSA2 (morfologik-stemming, LT) polish.dict"
	java $(javaopts) -jar $(morfologik) dict_compile --format cfsa2 -i build/polish.input --overwrite
	@echo "### Dumping raw automaton for polish.dict -> build/polish.dump"
	java $(javaopts) -jar $(morfologik) fsa_dump -i build/polish.dict -o build/polish.dump

#
# Build the synthesis dictionary.
#
build/polish_synth.dict: $(morfologik) build/polish_synth.input build/polish_synth.info
	@echo "### Building CFSA2 (morfologik-stemming, LT) polish_synth.dict"
	java $(javaopts) -jar $(morfologik) dict_compile --format cfsa2 -i build/polish_synth.input --overwrite
	@echo "### Dumping raw automaton for polish_synth.dict -> build/polish_synth.dump"
	java $(javaopts) -jar $(morfologik) fsa_dump -i build/polish_synth.dict -o build/polish_synth.dump

build/polish_synth.input: build/combined.input
	gawk -f awk/combined-to-synth.awk build/combined.input > build/polish_synth.input

#
# fsa_morph backwards-compatible dictionaries.
#
compile-fsamorph: build/fsa_morph/polish.dict \
                  build/fsa_morph/polish_synth.dict

build/fsa_morph/polish.dict: build/polish.dict
	mkdir -p build/fsa_morph
	@echo "### Building FSA5 (fsa_morph-compatible) polish.dict"
	tr ';+' '+|' < build/polish.input > build/fsa_morph/polish.input
	cp src/fsa_morph.info               build/fsa_morph/polish.info
	java $(javaopts) -jar $(morfologik) dict_compile --format fsa5  -i build/fsa_morph/polish.input --overwrite

build/fsa_morph/polish_synth.dict: build/polish_synth.dict
	mkdir -p build/fsa_morph
	@echo "### Building FSA5 (fsa_morph-compatible) polish_synth.dict"
	tr ';+' '+|' < build/polish_synth.input > build/fsa_morph/polish_synth.input
	cp src/fsa_morph.info                     build/fsa_morph/polish_synth.info
	java $(javaopts) -jar $(morfologik) dict_compile --format fsa5  -i build/fsa_morph/polish_synth.input --overwrite

#
# Extract unique tags
#
build/polish_tags.txt: build/combined.input
	LANG=C gawk -f awk/tags.awk build/combined.input | sort -u > build/polish_tags.txt

#
# Sanity checks.
#
.PHONY: test
test:
	cd lib && mvn test -Dpolish.dict=../build/polish.dict \
                     -Dpolish_synth.dict=../build/polish_synth.dict \
                     -Dcombined.input=../build/combined.input

#
# Substitute variables in template files.
#
TXT_FILES := $(wildcard src/*.txt)
build/%.txt: src/%.txt
	sed -e 's/$$version/$(version)/g' \
      -e 's/$$release_date/$(release_date)/g' \
      -e 's/$$copyright_date/$(copyright_date)/g' \
      -e 's/$$githash/$(githash)/g' \
      $< >$@

INFO_FILES := $(wildcard src/*.info)
build/%.info: src/%.info
	sed -e 's/$$version/$(version)/g' \
      -e 's/$$release_date/$(release_date)/g' \
      -e 's/$$copyright_date/$(copyright_date)/g' \
      -e 's/$$githash/$(githash)/g' \
      $< >$@

#
# Create a ZIP distribution.
#
.PHONY: zip
zip: compile compile-fsamorph \
     build/README.txt \
     build/README.Polish.txt \
     build/LICENSE.txt \
     build/LICENSE.Polish.txt
	rm -f build/polimorfologik-$(version_number).zip
	(cd build && zip -9 polimorfologik-$(version_number).zip \
         polish.info \
         polish.dict \
         polish_synth.info \
         polish_synth.dict \
         README.* \
         LICENSE.* \
         fsa_morph/*.dict )
	@echo -e "\n\n### Distribution ZIP ready: build/polimorfologik-$(version_number).zip"

#
# clean
#
.PHONY: clean
clean:
	rm -rf build
	rm -rf lib/target

