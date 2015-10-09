function atergo(str,	n, i, outp) {
	n = split(str,chars,"")
	outp = ""
	for (i = n; i>0; i--)
	outp = outp chars[i]
	return outp
}
BEGIN {
	FS=": "
	number[1]="sg"
	number[2]="pl"
	number[3]="pltant"
	gender[1]="f"
	gender[2]="n"
	gender[3]="m"
	variants_m[1]="m"
	variants_m[2]="m1"
	variants_m[3]="m2"
	variants_m[4]="m3"
	gcase[1]="nom"
	gcase[2]="gen"
	gcase[3]="acc"
	gcase[4]="dat"
	gcase[5]="inst"
	gcase[6]="loc"
	gcase[7]="voc"
}
/\#====:/ {cnt=-1}
{cnt++
	if (cnt==0) {
		subst = 0
		pltant = 0
		gcnt = 0
		for (j=1; j<=lemmaint_cnt; j++) {
			x = split(lemmaint[j], tags, ":")
			if (tags[1]=="subst") {
				gender_cand[gcnt++]=tags[x]
				subst = 1
				if (tags[2]=="pltant") {
					pltant = 1					
				}
			}
		}			
		if (subst==1) {	
			error = ""
			formstr = ""			
			for (j=0; j<=formcnt; j++) 
			formstr = formstr " " forms[j]
			#print formstr			
			for (j = 0; j <= gnct; j++) {
				if (pltant == 0) {
					for (k = 1; k <= 2; k++) {
						for (l = 1; l <= 7; l++) {
						if ((lemmaint[j+1] " " formstr)!~"subst:" number[k] ":[^ ]*" gcase[l] "[^ ]*" gender_cand[j]) {
						error = "found"
						other = ""
							if (gender_cand[j]~/m[1-3]/)
								for (m = 1; m <= 4; m++) 
									if ((lemmaint[j+1] " " formstr)!~"subst:" number[k] ":[^ ]*" gcase[l] "[^ ]*" variants_m[m]) 
										other = variants_m[m]																				
						if (other=="")
							print "Lemma " lemma " is missing form: " "subst:" number[k] ":" gcase[l] ":" gender_cand[j] #formstr
						else
							print lemma " => "gender_cand[j]						
						}						
					}
					}				
				} else {
					for (l = 1; l <= 7; l++)
					if (lemmaint[j+1] " " formstr!~"subst:pltant:[^ ]*" gcase[l] "[^ ]*" gender_cand[j]) {
					error = "found"
					print "Lemma " lemma " is missing form: " "subst:pltant:" gcase[l] ":" gender_cand[j]					
					}
				}
			}
		if (error=="")
			print "! " lemma " is correct and complete"
		} 
	}

if (cnt==1) {
	lemma=$1
	i = split($2, interps, ", ")
	lemmaint_cnt=0
	formcnt=0
	for (j=1; j<=i; j++) {
		n = split(interps[j], lemma_tag, "\+")		
		for (k = 2; k <= 4; k++) {		
		if (lemma_tag[1]==lemma) {
		if (lemma_tag[k]~/(pltant|sg):nom/) {
			lemmaint_cnt++
			lemmaint[lemmaint_cnt]=lemma_tag[k]			
		} else {		
			forms[formcnt++]=lemma_tag[k]			
			}
		}
	}		
	}
	#for (j=1;j<=lemmaint_cnt;j++)
		#print "lemm" lemmaint[j]	
} else {
	i = split($2, interps, ", ")		
	for (j = 1; j <= i; j++) {
		n = split(interps[j], lemma_tag, "\+")
		for (k = 2; k <= n; k ++)
		if (lemma_tag[1]==lemma) {							
			forms[formcnt++]=lemma_tag[k]			
		}
	}
}
}
