#skrypt wyodrêbnia do s³ownika wyrazów nieregularnych
#przys³ówki w stopniu najwy¿szym ze s³ownika znaczeñ kurnika
BEGIN {FS=": "}
/stopieñ najwy¿szy od przys³ówka/{print $1"\t"$3"\tadv:sup"}