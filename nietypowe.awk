#skrypt wyodrêbnia z pliku A w Ÿród³owym formacie ispella
#wyrazy pozbawione flag odmian, czyli rêcznie dopisane
#oraz nieodmienne
BEGIN {FS="\t"}
! /\//{print}