BEGIN {FS="\t"
glosfile="zwrotne.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1]="refl";
}
}
{output = $0
if (wyrazy[$2]=="refl") 
	output = gensub(/:(imperf|perf|\?perf)/,":refl:\\1","g")
	print output	
}

