BEGIN {FS=", "}
{for (i=1; i<=NF; i++)
	if ($i!="") print $i
print "#===="
	}