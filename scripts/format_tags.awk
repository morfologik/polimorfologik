BEGIN {FS="\t"}
!/:neg/ && !/qub/ {split($1,tags,"+")
for (n in tags)
print tags[n]
}