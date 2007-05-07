BEGIN {FS="\t"
glosfile="zwrotne.txt"; 
while ((getline < glosfile)  > 0){ 
	wyrazy[$1]="refl";
}
}
{output = $0
if (wyrazy[$2]=="refl") 
	output = gensub(/:(imperf|perf|\?perf)/,":refl:\\1","g")
if ($3=="adv:pos:aff")
	output = $1"\t"$1"\t"$3
if (!($2=="ty" && $3~/adj/))
	print output	
}

