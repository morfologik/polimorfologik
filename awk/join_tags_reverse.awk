BEGIN {FS="\t"}

#fix bardziej
/bardziej\tbardziej\tadv/ { $0 = "bardziej\tbardzo\tadv:com" }

# concatenate tags and reorder first two columns.
{
	key = $2 ";" $1
	if (key != prev) {
		if (i > 0) {
			printf "\n"
		}
		if (tag != "") {
			print "+" tag
			tag = ""
		}
		printf $2 ";" $1 ";" $3
		i++;
	} else {
		i = 0;
		if (tag == "") {
			tag = $3
		} else {
			tag = tag "+" $3
		}
	}
	prev = key
}
