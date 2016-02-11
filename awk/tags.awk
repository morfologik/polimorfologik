BEGIN { FS=";" }

{
  split($3, tags, "+")
	for (n in tags) {
		if (tags[n] !~ /:neg|qub/) {
			print tags[n]
		}
	}
}
