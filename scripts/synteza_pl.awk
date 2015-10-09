BEGIN {FS="\t"}
{split($3, tags, "+")
for (n in tags)
		if (tags[n]!~/:neg|qub|depr/)
		print $2"|"tags[n]"\t"$1
}
