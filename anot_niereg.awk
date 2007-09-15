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
	nieodm[$1"\t"$2]=$3"nieodm";
}

verb_qub["grze¶æ"]="imperf"
verb_qub["k³uæ"]="imperf"
verb_qub["pogrze¶æ"]="perf"
verb_qub["rozemleæ"]="perf"
verb_qub["zemleæ"]="perf"
verb_qub["lec"]="perf"
verb_qub["za¿ec"]="perf"

imiesl["±ca"]="pact:sg:nom.voc:f:aff"
imiesl["±ce"]="pact:sg:nom.acc.voc:n:aff+pact:pl:nom.acc.voc:f.n.m2.m3:aff"
imiesl["±cego"]="pact:sg:gen:m2.m3.n:aff+pact:sg:acc.gen:m1:aff"
imiesl["±cej"]="pact:sg:gen.dat.loc:f:aff"
imiesl["±cemu"]="pact:sg:dat:m.n:aff"
imiesl["±cy"]="pact:sg:nom.acc:m3:aff+pact:sg:nom.voc:m1.m2:aff+pact:pl:nom.voc:m1.m2:aff"
imiesl["±cych"]="pact:pl:acc.gen.loc:m1:aff+pact:pl:gen.loc:f.n.m2.m3:aff"
imiesl["±cym"]="pact:sg:inst.loc:m.n:aff+pact:pl:dat:f.m.n:aff"
imiesl["±cymi"]="pact:pl:inst:f.m.n:aff"
imiesl["±c±"]="pact:sg:acc.inst:f:aff"

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

fin["je"]="verb:fin:sg:ter"
fin["gnie"]="verb:fin:sg:ter"
fin["mie"]="verb:fin:sg:ter"
fin["[ie]cie"]="verb:fin:pl:sec"
fin["emy"]="verb:fin:pl:pri"
fin["esz"]="verb:fin:sg:sec"
fin["±"]="verb:fin:pl:ter"
fin["ê"]="verb:fin:sg:pri"

impt["¿e"]="verb:impt:sg:sec"
impt["[^eai¶]my"]="verb:impt:pl:pri"
impt["cie¿"]="verb:impt:pl:sec"
impt["[^eai¶rê]cie"]="verb:impt:pl:sec"
impt["[jñ]my¿"]="verb:impt:pl:pri"
impt["[uaoi]j"]="verb:impt:sg:sec"
impt["rzej"]="verb:impt:sg:sec"

pot["³aby"]="verb:pot:praet:sg:ter:f"		
pot["³abym"]="verb:pot:praet:sg:pri:f"
pot["³aby¶"]="verb:pot:praet:sg:sec:f"
pot["³oby"]="verb:pot:praet:sg:ter:n"
pot["³by"]="verb:pot:praet:sg:ter:m"
pot["³bym"]="verb:pot:praet:sg:pri:m"
pot["³by¶"]="verb:pot:praet:sg:sec:m"
pot["liby"]="verb:pot:praet:pl:ter:m1"
pot["liby¶cie"]="verb:pot:praet:pl:sec:m1"
pot["liby¶my"]="verb:pot:praet:pl:pri:m1"
pot["³yby"]="verb:pot:praet:pl:ter:f.n"
pot["³yby¶cie"]="verb:pot:praet:pl:sec:f.n"
pot["³yby¶my"]="verb:pot:praet:pl:pri:f.n"

praet["³em"]="verb:praet:sg:pri:m"
praet["³e¶"]="verb:praet:sg:sec:m"
praet["³"]="verb:praet:sg:ter:m"
praet["³am"]="verb:praet:sg:pri:f"
praet["³a¶"]="verb:praet:sg:sec:f"
praet["³a"]="verb:praet:sg:ter:f"
praet["³o"]="verb:praet:sg:ter:n"
praet["li¶my"]="verb:praet:pl:pri:m1"
praet["li¶cie"]="verb:praet:pl:sec:m1"
praet["li"]="verb:praet:pl:ter:m1"
praet["³y¶my"]="verb:praet:pl:pri:f.n"
praet["³y¶cie"]="verb:praet:pl:sec:f.n"
praet["³y"]="verb:praet:pl:ter:f.n"

ppas["[tn]a"]="ppas:sg:nom.voc:f"		
ppas["[tn]e"]="ppas:sg:nom.acc.voc:n+ppas:pl:nom.acc.voc:f.n.m2.m3"		
ppas["[tn]ego"]="ppas:sg:gen:m2.m3.n+ppas:sg:acc.gen:m1"		
ppas["[tn]ej"]="ppas:sg:gen.dat.loc:f"		
ppas["[tn]emu"]="ppas:sg:dat:m.n"		
ppas["[tn]i"]="ppas:pl:nom.voc:m1"		 		
ppas["[tn]y"]="ppas:sg:nom.acc.voc:m3+ppas:sg:nom.voc:m1.m2"				
ppas["[tn]ych"]="ppas:pl:acc.gen.loc:m1+ppas:pl:gen.loc:f.n.m2.m3"		
ppas["[tn]ym"]="ppas:sg:inst.loc:m.n+ppas:pl:dat:f.m.n"		
ppas["[tn]ymi"]="ppas:pl:inst:f.m.n"		 		
ppas["[tn]±"]="ppas:sg:acc.inst:f"

ger["[cn]ia"]="subst:ger:pl:nom.acc.voc:n+subst:ger:sg:gen:n"
ger["[cn]iach"]="subst:ger:pl:loc:n"
ger["[cn]iami"]="subst:ger:pl:inst:n"
ger["(rc|n)ie"]="subst:ger:sg:nom.acc.voc:n"
ger["(rc|n)iem"]="subst:ger:sg:inst:n"
ger["(rc|n)iom"]="subst:ger:pl:dat:n"
ger["[cn]iu"]="subst:ger:sg:dat.loc:n"
ger["[æñ]"]="subst:ger:pl:gen:n"

}
{

if (nieodm[$1"\t"$2]=="" && (wyrazy[$1"\t"$2]=="" || $2 in verb_qub))
	{
	detected=""
	if (wyrazy[$3"\t"$2]!="" || $2 in verb_qub) {
	lastelement = split(wyrazy[$3"\t"$2], znaczniki, ":")
	if (znaczniki[1]~/ppas/) {
		aspekt = "?perf"
	} else {
		if (znaczniki[lastelement]~/perf/) 
		aspekt = znaczniki[lastelement]		
		else
		aspekt = "?perf"
	}
	
	if ($2 in verb_qub) {
		aspekt=verb_qub[$2]
		znaczniki[1]="verb"
		}
		
	
	if ($2"__END"~/æ__END/ && znaczniki[1]~/adj|pact|subst:ger/)
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
		detected="true"
		}
	else
	if ($1"__END"~/owo__END/ && $2"__END"~/owy__END/)
	{
		print $1"\t"$2"\tadv:pos"
		detected="true"
		}
	else 
	if ($1"__END"~/[^g]o__END/ && znaczniki[1]~/adj/) {
		detected="true"
		print $1"\t"$2"\tadv:pos"	
		}	
	else 			
	if (znaczniki[1]~/verb|ppas/) {
		for (im in imiesl) {
		imieslow = im"__END"
		if ($1"__END"~imieslow) {
		 print $1"\t"$2"\t"imiesl[im]
		 detected="true"
		 }
		}
		if (detected!="true") {
		for (koncowka in impt) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = impt[koncowka]
		if (aspekt=="")
			aspekt=znaczniki[lastelement]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma":"aspekt
		 detected="true"
		 }
		}
		}
		
		if (detected!="true") {
		for (koncowka in pot) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = pot[koncowka]
		if (aspekt=="")
			aspekt=znaczniki[lastelement]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma":"aspekt
		 detected="true"
		 }
		}
		}
		
		if (detected!="true") {
		for (koncowka in praet) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = praet[koncowka]
		if (aspekt=="")
			aspekt=znaczniki[lastelement]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma":"aspekt
		 detected="true"
		 }
		}
		}

		if (detected!="true") {
		for (koncowka in ppas) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = ppas[koncowka]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma
		 detected="true"
		 }
		}
		}		

		if (detected!="true") {
		for (koncowka in fin) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = fin[koncowka]
		if (aspekt=="")
			aspekt=znaczniki[lastelement]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma":"aspekt
		 detected="true"
		 break
		 }
		}
		}

		if (detected!="true") {
		for (koncowka in ger) {		
		czasownik= koncowka"__END"
#		print czasownik
		forma = ger[koncowka]
		if ($1"__END"~czasownik) {
		 print $1"\t"$2"\t"forma
		 detected="true"
		 }
		}
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
		if ($1"__END"~/[wlmñbjp¼æ]cze__END/ && $2"__END"~/([wnmbcpz]i|l)ec__END/ && znaczniki[1]~/subst/)
			print $1"\t"$2"\tsubst:sg:voc:m1"											
	else 
		if($1"__END"~/±ce__END/ && $2"__END"~/±cy__END/ && znacznik[1]~/subst/)
			print $1"\t"$2"\tsubst:pl:nom.acc.voc:m1:depr"
	else 
		if($1"__END"~/[cn]iu__END/ && $2"__END"~/[cn]ia__END/ && znacznik[1]~/subst/) 
			print $1"\t"$2"\tsubst:sg:voc:f"
	else 
		if($1"__END"~/ru__END/ && $2"__END"~/r__END/ && znacznik[1]~/subst/) 
			print $1"\t"$2"\tsubst:sg:gen:m2"						
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
	else 
		print $1 "\t" $2 "\tqub"
	}
}