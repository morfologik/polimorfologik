#Skrypt usuwa nieuzywane flagi z pliku 
#bazy danych morfosyntaktycznych
#morfo_baza.txt
#i zapisuje nowy plik na wyjsciu

function sort_flags(flag) {
   sort_flagi=""
   split(flag, flagi,"")
   n = asort(flagi)
   for (i = 1; i <= n; i++)
      sort_flagi=sort_flagi flagi[i]	
  return sort_flagi
}

BEGIN {FS="/"
dictionary="polish.all"; #ispell file
while ((getline < dictionary)  > 0){ 
	if ($2!=""){
	flagi_ispell=sort_flags($2)
#	print flagi_ispell
#	print $2
	if (flags[flagi_ispell]=="")
		flags[flagi_ispell]=flagi_ispell
	}
}

FS="\t"
}
{if (flags[$1]!="" || $1=="")
	print 
	#"Empty def:" $0
	}

