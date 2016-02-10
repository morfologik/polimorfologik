
morfologik = lib/morfologik-tools-2.0.1.jar
sortopts   = --buffer-size=1G
javaopts   = -ea -Xmx1G
input      = eksport.tab

#
# Everything.
#
all: build/polish.dict

#
# Fetch morfologik-tools (FSA compilers) using Apache Maven.
#
$(morfologik):
	cd lib && mvn

#
# Preprocess the raw input.
#
build/combined.tab:
	mkdir -p build
	LANG=C sort $(sortopts) -u $(input) eksport.quickfix.tab | gawk -f awk/join_tags_reverse.awk > build/combined.tab

#
# Build the stemming dictionary.
#
build/polish.dict: $(morfologik) build/combined.tab build/polish.info
	cp build/combined.tab build/polish.input
	java $(javaopts) -jar $(morfologik) dict_compile --format fsa5 -i build/polish.input --overwrite

build/polish.info: src/polish.info awk/version_script.awk
	gawk -f awk/version_script.awk src/polish.info > build/polish.info
