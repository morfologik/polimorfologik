BEGIN { FS=";" }

{
	split($3, tags, "+")
	for (n in tags) {
		if (tags[n] !~ /:neg|qub|depr/) {
			print $2 ";" $1 "|" tags[n]
		}
	}
}