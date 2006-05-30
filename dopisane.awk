#program do odfiltrowania nieodmiennych wyrazów i wyrazów o dopisanych rêcznie
BEGIN {FS=" "
glosfile="bez_flag.txt"; #wyrazy uzyskane ze skryptu nieodmienne, czyli odfiltrowane
#z pliku ispella bez flag odmian
while ((getline < glosfile)  > 0){ 
	wyrazy[$1]=$1;
}
}
{found = 0
for (i=2; i<=NF; i++) 
	if (wyrazy[$i]!="") 
		{
		numer=0
		for (j=2;j<=NF;j++)
		if ((i!=j)  && (wyrazy[$j]=="") && (numer==0))
			numer = j
		if (numer>0)
		print wyrazy[$i] "\t" $1 "\t" $numer
		else
		print wyrazy[$i] "\t" $1
		found=1
		}
#if (found==0) print $1 "\t" $1 "\t" "wyraz nieodmienny"
		}