# join.awk --- join an array into a string
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}
{split($0, tags_to_sort, "[\.:]")
n = asort(tags_to_sort)
index_str = join(tags_to_sort,0,n)
#print index_str
if (tags[index_str]!="")
	tags[index_str] = tags[index_str] " " $0
else 
	tags[index_str] = $0
}
END {for (n in tags)
	if (tags[n]~/ / && n!="")
		print "Duplicate tags: " tags[n] "<-" n
}