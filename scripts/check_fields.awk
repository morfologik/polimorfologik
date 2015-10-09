BEGIN {FS="\t"}
{if (NF!=3) print "Error in line: " $0
 for (n=1;n<=3;n++)
	if ($n=="") print "Missing field #" n " - "$0 
 }