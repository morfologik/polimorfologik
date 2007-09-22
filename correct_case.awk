# skrypt wybiera z pliku odm.txt te rzeczowniki, których formy na -u
# s± jednocze¶nie formami miejscownika i wo³acza, a nie tylko
# dope³niacza, jak przy pozosta³ych rzeczownikach z flagami QSTs
#
# skrypt wykonuje filtrowanie na pliku
# slownik_regularny.txt, tj. ma wyszukiwaæ formê na -u wyrazu z tablicy locvoc
# i zamieniaæ j± na formê poprawn±
 
BEGIN {FS="\/"
glosfile="polish.all"; 
while ((getline < glosfile)  > 0){
	if ($2~/[QSTs][QSTs][QSTs][QSTs]/) {
	 gen[$1]=$1	 
    }
    }
FS=","    
glosfile="odm.txt"; 
while ((getline < glosfile)  > 0){
 if ($0~/u,/ && $0!~/[^w]ie,/ && $0!~/y,/ && $0~/owi,/) {
  if ($1 in gen)	
	 locvoc[$1]=$1	 
    }
    }
FS="\t"    
}

{if ($2 in locvoc && $1==$2"u")
    print $1"\t"$2"\tsubst:sg:gen.loc.voc:m"
  else 
    print
}
