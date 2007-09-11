BEGIN {FS="\t"}
{if ($2=="J" && $6!~/verb/) {
	print "Niezgodno뜻 flagi! " $0
}
if ($2=="I" && $6!~/verb/) {
	print "Niezgodno뜻 flagi! " $0
}
if ($2=="G" && $6!~/adj/) {
	print "Niezgodno뜻 flagi! " $0
}
if ($2=="H" && $6!~/verb/) {
	print "Niezgodno뜻 flagi! " $0
}

if ($1=="MNT" && $6~/.*:f/) {
	print "Niezgodny rodzaj: " $0
}
if ($1=="MST" && $6~/.*:f/) {
	print "Niezgodny rodzaj: " $0
}
if ($1=="MNTo" && $6~/.*:f/) {
	print "Niezgodny rodzaj: " $0
}
if ($1~/T/ && $6~/.*:f/) {
	print "Niezgodny rodzaj: " $0
}

if ($6=="") 
	print "Brak definicji znacznika: " $0
if ($7!="") 
	print "Nadmiarowe pole w wersie: " $0
	
}
