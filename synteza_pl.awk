BEGIN {FS="\t"}
!/:neg/ && !/qub/ && !/irreg/ {split($3, tags, "+")
for (n in tags)
	print $2"|"tags[n]"\t"$1
}