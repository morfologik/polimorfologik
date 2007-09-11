#na podstawie form regularnych
BEGIN {FS="\t"
#wyrazy regularne, wygenerowane skryptem morpher.awk
#wczytanie trwa dosyc dlugo, ale nic dziwnego!
glosfile="slownik_regularny.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1"\t"$2]=$3;
}

glosfile="slownik_nieregularny.txt"; 
while ((getline < glosfile)  > 0){ 
	nieodm[$1"\t"$2]=$3;

}

imiesl["±ca"]="pact:sg:nom.voc:f:pos:aff"
imiesl["±ce"]="pact:sg:nom.acc.voc:n:pos:aff+pact:pl:nom.acc.voc:f.n.m2.m3:pos:aff"
imiesl["±cego"]="pact:sg:gen:m2.m3.n:pos:aff+pact:sg:acc.gen:m1:pos:aff"
imiesl["±cej"]="pact:sg:gen.dat.loc:f:pos:aff"
imiesl["±cemu"]="pact:sg:dat:m.n:pos:aff"
imiesl["±cy"]="pact:sg:nom.acc:m3:pos:aff+pact:sg:nom.voc:m1.m2:pos:aff+pact:pl:nom.voc:m1.m2:pos:aff"
imiesl["±cych"]="pact:pl:acc.gen.loc:m1:pos:aff+pact:pl:gen.loc:f.n.m2.m3:pos:aff"
imiesl["±cym"]="pact:sg:inst.loc:m.n:pos:aff+pact:pl:dat:f.m.n:pos:aff"
imiesl["±cymi"]="pact:pl:inst:f.m.n:pos:aff"
imiesl["±c±"]="pact:sg:acc.inst:f:pos:aff"

przym["a"]="adj:sg:nom.voc:f:pos:aff"
przym["e"]="adj:sg:nom.acc.voc:n:pos:aff+adj:pl:nom.acc.voc:f.n.m2.m3:pos:aff"
przym["ego"]="adj:sg:gen:m2.m3.n:pos:aff+adj:sg:acc.gen:m1:pos:aff"
przym["ej"]="adj:sg:gen.dat.loc:f:pos:aff"
przym["emu"]="adj:sg:dat:m.n:pos:aff"
przym["i"]="adj:pl:nom.voc:m1:pos:aff"
przym["yn"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["aw"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["en"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["ent"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["ó³"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["ów"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["yt"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["yw"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["om"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["y"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["iw"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["in"]="adj:sg:nom.acc:m3:pos:aff+adj:sg:nom.voc:m1.m2:pos:aff"
przym["ich"]="adj:pl:acc.gen.loc:m1:pos:aff+adj:pl:gen.loc:f.n.m2.m3:pos:aff"
przym["ych"]="adj:pl:acc.gen.loc:m1:pos:aff+adj:pl:gen.loc:f.n.m2.m3:pos:aff"
przym["im"]="adj:sg:inst.loc:m.n:pos:aff+adj:pl:dat:f.m.n:pos:aff"
przym["ym"]="adj:sg:inst.loc:m.n:pos:aff+adj:pl:dat:f.m.n:pos:aff"
przym["imi"]="adj:pl:inst:f.m.n:pos:aff"
przym["ymi"]="adj:pl:inst:f.m.n:pos:aff"
przym["±"]="adj:sg:acc.inst:f:pos:aff"


}
{if (nieodm[$1"\t"$2]=="" && wyrazy[$1"\t"$2]=="")
	{
	detected=""
	if (wyrazy[$3"\t"$2]!="") {
	lastelement = split(wyrazy[$3"\t"$2], znaczniki, ":")
	if (znaczniki[1]~/ppas/) {
		aspekt = "?perf"
	} else {
		if (znaczniki[lastelement]~/perf/) 
		aspekt = znaczniki[lastelement]		
		else
		aspekt = "?perf"
	}
		
	if ($2"__END"~/æ__END/ && znacznik[1]~/adj|pact/)
		znaczniki[1]="verb"
	
	if ($1"__END"~/±c__END/ && znaczniki[1]~/verb|ppas/) 
		{
		print $1"\t"$2"\tpcon:imperf"
		if (aspekt!="imperf" && aspekt!="?perf")
			print "Blad oznaczenia aspektu: " aspekt ": " $2 >>"aspekt.txt"
		else 
			aspekt="imperf"
		}
	else
	if ($1"__END"~/[³w]szy__END/) {
		print $1"\t"$2"\tpant:perf"
		if (aspekt!="perf" && aspekt!="?perf")
			print "Blad oznaczenia aspektu: " aspekt ": " $2 >>"aspekt.txt"
		else 
			aspekt="perf"
		
		}
	else
	if ($1"__END"~/owo__END/ && $2"__END"~/owy__END/)
		print $1"\t"$2"\tadv:pos"
	else 
	if ($1"__END"~/[^g]o__END/ && znaczniki[1]~/adj/) {
		detected="true"
		print $1"\t"$2"\tadv:pos"	
		}
	else
	if ($1"__END"~/¿e__END/ && znaczniki[1]~/verb|ppas|adj/)	
		print $1"\t"$2"\tverb:impt:sg:sec:"aspekt
	else
	if ($1"__END"~/[^eai¶]my__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:pl:pri:"aspekt
	else
	if ($1"__END"~/³aby__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:ter:f:"aspekt		
	else
	if ($1"__END"~/³abym__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:pri:f:"aspekt
	else
	if ($1"__END"~/³aby¶__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:sec:f:"aspekt
	else
	if ($1"__END"~/³oby__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:ter:n:"aspekt
	else
	if ($1"__END"~/³by__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:ter:m:"aspekt
	else
	if ($1"__END"~/³bym__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:pri:m:"aspekt
	else
	if ($1"__END"~/³by¶__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:sg:sec:m:"aspekt
	else	
	if ($1"__END"~/liby__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:ter:m1:"aspekt
	else
	if ($1"__END"~/liby¶cie__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:sec:m1:"aspekt
	else
	if ($1"__END"~/liby¶my__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:pri:m1:"aspekt
	else
	if ($1"__END"~/³yby__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:ter:f.n:"aspekt
	else
	if ($1"__END"~/³yby¶cie__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:sec:f.n:"aspekt
	else
	if ($1"__END"~/³yby¶my__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:pot:praet:pl:pri:f.n:"aspekt
	else	
	if ($1"__END"~/³em__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:pri:m:"aspekt
	else
	if ($1"__END"~/³e¶__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:sec:m:"aspekt
	else
	if ($1"__END"~/³__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:ter:m:"aspekt
	else
	if ($1"__END"~/³am__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:pri:f:"aspekt
	else
	if ($1"__END"~/³a¶__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:sec:f:"aspekt
	else
	if ($1"__END"~/³a__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:ter:f:"aspekt
	else
	if ($1"__END"~/³o__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:sg:ter:n:"aspekt
	else
	if ($1"__END"~/li¶my__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:pri:m1:"aspekt
	else
	if ($1"__END"~/li¶cie__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:sec:m1:"aspekt
	else
	if ($1"__END"~/li__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:ter:m1:"aspekt
	else
	if ($1"__END"~/³y¶my__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:pri:f.n:"aspekt
	else
	if ($1"__END"~/³y¶cie__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:sec:f.n:"aspekt
	else
	if ($1"__END"~/³y__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:praet:pl:ter:f.n:"aspekt
	else
	if ($1"__END"~/cie¿__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:pl:sec:"aspekt
	else
	if ($1"__END"~/jcie__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:pl:sec:"aspekt
	else
	if ($1"__END"~/jmy__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:pl:pri:"aspekt
	else
	if ($1"__END"~/jmy¿__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:pl:pri:"aspekt
	else
	if ($1"__END"~/[uaoi]j__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:sg:sec:"aspekt
	else
	if ($1"__END"~/rzej__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tverb:impt:sg:sec:"aspekt
	if ($1"__END"~/na__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:nom.voc:f"		
	else 
	if ($1"__END"~/ne__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:nom.acc.voc:n+ppas:pl:nom.acc.voc:f.n.m2.m3"		
	else 		
	if ($1"__END"~/nego__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:gen:m2.m3.n+ppas:sg:acc.gen:m1"		
	else 
	if ($1"__END"~/nej__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:gen.dat.loc:f"		
	else 
	if ($1"__END"~/nemu__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:dat:m.n"		
	else 	
	if ($1"__END"~/ni__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:pl:nom.voc:m1"		
	else 		
	if ($1"__END"~/ny__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:nom.acc.voc:m3+ppas:sg:nom.voc:m1.m2"		
	else 		
	if ($1"__END"~/nych__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:pl:acc.gen.loc:m1+ppas:pl:gen.loc:f.n.m2.m3"		
	else 		
	if ($1"__END"~/nym__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:inst.loc:m.n+ppas:pl:dat:f.m.n"		
	else 		
	if ($1"__END"~/nymi__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:pl:inst:f.m.n"		
	else 		
	if ($1"__END"~/n±__END/ && znaczniki[1]~/verb|ppas/)
		print $1"\t"$2"\tppas:sg:acc.inst:f"		
	else 			
	if (znaczniki[1]~/verb|ppas/) {
		for (im in imiesl) {
		imieslow = im"__END"
		if ($1"__END"~imieslow)
		 print $1"\t"$2"\t"imiesl[im]
		}
	}
	else	
		if ($1"__END"~/owi__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:dat:m1"
	else 
		if ($1"__END"~/owi__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:dat:m1"			
	else 
		if ($1"__END"~/ssem__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:inst:m1"						
	else 
		if ($1"__END"~/ssa__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:acc.gen:m1"									
	else			
		if ($1"__END"~/[wlmñ]cze__END/ && $2"__END"~/([wnm]i|l)ec__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:voc:m1"											
	else {
	if (znaczniki[1]~/ad[jv]/) {
		for (koncowka in przym) {
		przymiotnik = koncowka"__END"
		forma = przym[koncowka]
		if ("START_"$1~/START_nie/ && "START_"$2!~/START_nie/)
			forma = gensub("aff","neg","g",forma)
		if ($1"__END"~przymiotnik) {
		 print $1"\t"$2"\t"forma
		 detected="true"
		 }
		}
	}
	if (detected!="true")
		print $1"\t"$2"\t"znaczniki[1]":irreg" 
	}
	}
	else print $1 "\t" $2 "\tqub"
	}
}