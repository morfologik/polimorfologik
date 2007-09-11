 # Print list of word frequencies
     {
         #	for (i = 1; i <= NF; i++)
             freq[$0]++
     }
     
     END {
         for (word in freq)
             printf "%s\t%d\n", word, freq[word]
     }