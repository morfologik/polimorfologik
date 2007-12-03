#program s³u¿¹cy do anotacji morfologicznej

function sort_flags(flag) {
   sort_flagi=""
   split(flag, flagi,"")
   n = asort(flagi)
   for (i = 1; i <= n; i++)
      sort_flagi=sort_flagi flagi[i]

  return sort_flagi
}

function negate_pos(pos) {
negated_pos=""
split(pos,elements,"+")
for (n in elements)
   if (negated_pos=="") {
   if (pos~/adj:/)
		negated_pos=elements[n]  ":pos:neg"
	else 
		negated_pos=elements[n] ":neg" 
	}
    else {
	if (pos~/adj:/)
		negated_pos=negated_pos "+" elements[n] ":pos:neg" 
	else
	negated_pos=negated_pos "+" elements[n] ":neg" 
	}
if (negated_pos=="") print "##B³±d konwersji" pos
return negated_pos 
}

function can_negate_pos(pos) {
negated_pos=""
split(pos,elements,"+")
for (n in elements)
   if (negated_pos=="") {	
	if (pos~/adj:/)
		negated_pos=elements[n]  ":pos:aff"
	else 
		negated_pos=elements[n] ":aff" 
	}
    else 
	{	
	if (pos~/adj:/)
		negated_pos=negated_pos "+" elements[n] ":pos:aff" 
	else
		negated_pos=negated_pos "+" elements[n] ":aff"
	}
if (negated_pos=="") print "##B³±d konwersji" pos
return negated_pos 
}

BEGIN {FS="\t"
glosfile="morfo_baza.txt"; #s³ownik anotacje ispell - anotacje morfosyntaktyczne
while ((getline < glosfile)  > 0){
	
	lexem_flag=sort_flags($1)
	form_flag=sort_flags($2)

	if (lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5]=="" ||lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5]==$6)
		lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5]=$6
	else 
		{
		split($6, anotacje, "+")
		for (n in anotacje)
		if (match(lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5], anotacje[n]))
		{sklejone++}
		else		
		lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5]=lista_obecnosci[lexem_flag FS form_flag FS$3FS$4FS$5]"+"anotacje[n]
		}
	}

}

{

lexem_flag=gensub(/[b\!]/,"","g", sort_flags($3))
form_flag=gensub(/[b\!]/,"","g", sort_flags($4))

#specjalny znacznik do regu³y pisowni ³±czniej z "nie"
potencjalna_negacja=""
if (($3~/b/ || ($4~/[Ggv]/ && $3~/H/ && $5!="0" && $6!="0")) && $4!~/b/)
	potencjalna_negacja=":aff"
#stopieñ najwy¿szy
stopien=""
if (potencjalna_negacja=="" && $2"__END"~/naj.*[ñhdktbpjwr¿l]szy__END/)
	stopien=":sup"
#stopieñ wy¿szy
if (potencjalna_negacja=="" && stopien=="" && $2"__END"~/.*[ñhdktbpjwr¿l]szy__END/)
	stopien=":comp"
if ($4~/b/) 
if (sort_flags($3)!=sort_flags($4)) 
	print $1FS$2FS negate_pos(lista_obecnosci[lexem_flag FS form_flag FS$5FS$6FS$7]) 
else	
	#forma podstawowa bez negacji
	print $1FS$2FS can_negate_pos(lista_obecnosci[lexem_flag FS form_flag FS$5FS$6FS$7])	

else {
if (lista_obecnosci[ lexem_flag FS form_flag FS$5FS$6FS$7]!="")
{
split(lista_obecnosci[lexem_flag FS form_flag FS$5FS$6FS$7],znaczniki_pos,"+")
plus=""
znacznik=""
for (ppp in znaczniki_pos)
	{
	if (znaczniki_pos[ppp]~/adj/ && znaczniki_pos[ppp]!="adjp" && stopien =="")
		stopien = ":pos"
	if (stopien!="" && znaczniki_pos[ppp]~/adj/) znacznik=znacznik plus znaczniki_pos[ppp] stopien potencjalna_negacja
	else 
	znacznik=znacznik plus znaczniki_pos[ppp] potencjalna_negacja 
	plus="+"
	}
	{print $1FS$2FS znacznik}
}
else
	print "##" lexem_flag FS form_flag FS$5FS$6FS$7 FS $1FS$2FS
	}
}
