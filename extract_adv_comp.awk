#skrypt wyodrêbnia do s³ownika wyrazów nieregularnych
#przys³ówki w stopniu wy¿szym ze s³ownika znaczeñ kurnika
BEGIN {FS=": "}
/stopieñ wy¿szy od przys³ówka/{print $1"\t"$3"\tadv:comp"}