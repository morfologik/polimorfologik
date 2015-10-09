#fix bardziej
/bardziej\tbardziej\tadv/{$0 = "bardziej\tbardzo\tadv:com"}
{if ($1 "\t" $2 != prev) {
	if (i > 0) {
		printf "\n"
		}
	if (tag != "") {
		print "+" tag
		tag = ""
		}	
	printf $0
	i++;
	
	} else {
		i = 0;
		if (tag == "")
			tag = $3
		else
			tag = tag "+" $3
		
		}
	prev = $1 "\t" $2	

}
	