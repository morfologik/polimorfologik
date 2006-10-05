BEGIN {FS="\t"
morfo_baza="morfo_baza.txt"; #created file
while ((getline < morfo_baza)  > 0){ 
		pos_nolemmaflag[$2FS$3FS$4FS$5]=$6
#		pos_noending[$1FS$2FS$3FS$4]=$6
		}
}

{gsub("##","")
print $1FS$2FS$3FS$4FS$5FS pos_nolemmaflag[$2FS$3FS$4FS$5] FS FS"#"$6
#print "b) " $0 FS pos_noending[$1FS$2FS$3FS$4]
}

