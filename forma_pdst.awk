#skrypt do korelowania podstawowych form s³ów (bez koñcówek)
#z tagami
#wejœciowy plik: A w formacie ispella (nie myspella!)
BEGIN {FS="\/"}
{if (NF>1) print $1"\t"$1"\t"$2"\t"$2"\t0\t0\t"}