BEGIN {FS="[ ]+"
affixfile="pl_PL.aff"; #plik afiksów
while ((getline < affixfile)  > 0){ 
	if ($5=="" && $1=="SFX") {
	down_counter_sfx=$4
	koncowki[$2 "count"]=down_counter_sfx
	}
	if ($5!="" && $1=="SFX") {
	koncowki[$2 down_counter_sfx "cut"]=$3
	if ($4!="0")
		koncowki[$2 down_counter_sfx "suffix"]=$4
	koncowki[$2 down_counter_sfx "stem"]=$5
	down_counter_sfx--
		}
	if ($5=="" && $1=="PFX") {
	down_counter_pfx=$4
	prefiksy[$2 "count"]=down_counter_pfx
	}
	if ($5!="" && $1=="PFX") {
	prefiksy[$2 down_counter_pfx]=$3"\t"$4"\t"$5
	down_counter_pfx--
	}
}
FS=" |/"
}

/\//{
wyraz1=tolower($1)"__END_"
wyraz=$1"__END_"
split($2, flagi,"")
for (n in flagi)
	{
	counter = koncowki[flagi[n] "count"]
	if (counter!=0) 
	for (k=1;k<=counter;k++)
		{						
		if (wyraz1~koncowki[flagi[n] k "stem"]"__END_") {
		cut = koncowki[flagi[n] k "cut"]		
		if (cut!="0") rdzen = gensub("__END_","","g",gensub(cut"__END_","",1, wyraz))
				else rdzen = $1
		print rdzen koncowki[flagi[n] k "suffix"]"\t"$1"\t"$2"\t"flagi[n]"\t"cut"\t"koncowki[flagi[n] k "suffix"]"\t"koncowki[flagi[n] k "stem"]
		if ($2~/b/)
			print "nie" rdzen koncowki[flagi[n] k "suffix"]"\t"$1"\t"$2"\tb"flagi[n]"\t"cut"\t"koncowki[flagi[n] k "suffix"]"\t"koncowki[flagi[n] k "stem"]		
		}		
		}
	
	}
}
