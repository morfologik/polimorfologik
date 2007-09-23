# skrypt wybiera z pliku odm.txt te rzeczowniki, których formy na -u
# s± jednocze¶nie formami miejscownika i wo³acza, a nie tylko
# dope³niacza, jak przy pozosta³ych rzeczownikach z flagami QSTs
#
# skrypt wykonuje filtrowanie na pliku slownik_regularny.txt
# 1) ma wyszukiwaæ formê na -u wyrazu z tablicy locvoc
# i zamieniaæ j± na formê poprawn±
# 2) wynajduje rzeczowniki blp, których nom = acc = gen = voc
 
BEGIN {FS="\/"
glosfile="polish.all"; 
while ((getline < glosfile)  > 0){
	if ($2~/[QSTs][QSTs][QSTs][QSTs]/) {
	 gen[$1]=$1	 
    }
  if ($2=="W") {
    pltant[$1]=$1
  }
  if ($2~/M/ && $2!~/A/) {
    datloc[$1]=$1
  if ($2~/N/ && $2!~/o/) {
    pluralis[$1]=$1
  }    
  }
  
    }
FS=","    
glosfile="odm.txt"; 
while ((getline < glosfile)  > 0){
 if ($0~/u,/ && $0!~/[^w]ie,/ && $0!~/y,/ && $0~/owi,/) {
  if ($1 in gen)	
	 locvoc[$1]=$1	 
    }
  if ($1 in pltant) {
  if ($0!~/[^ihm],/)
    pltantaccgen[$1]=$1  
  }
  
  if ($1 in datloc) {  
    if ($0~/([lic]|rz)e,/) {
        datlocnotgen[$1]=$1
        #print $1
    }  
  }
}
  
irregular["rêka"]="rêka"
    
FS="\t"    
}

{if ($2 in locvoc && $1==$2"u")
    print $1"\t"$2"\tsubst:sg:gen.loc.voc:m"    
  else 
if ($1==$2 && $1 in pltantaccgen)
    print $1"\t"$2"\tsubst:pltant:nom.acc.gen.voc:n"
  else
if ($2 in datlocnotgen && $1"__END"~/y__END/ && $3~/subst:/) {
    tag_num=split($3,znaczniki, ":")
    rodzaj = znaczniki[tag_num]
    if (rodzaj=="depr")
        rodzaj = znaczniki[tag_num - 1]
    if ($2 in pluralis) {
        rodzaj = rodzaj "+subst:pl:nom.acc.voc:" rodzaj
    }
    print $1"\t"$2"\tsubst:sg:gen:" rodzaj
    }
else
    if (!($2 in irregular))    
    print
}
