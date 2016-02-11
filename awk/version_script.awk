BEGIN {
version="2.1 PoliMorf"
"date +%Y" | getline cop_date;
"date" | getline creation;
}
/\$v/ {gsub(/\$v/, version)}
/\$d/ {gsub(/\$d/, cop_date)}
/\$build/ {gsub(/\$build/, creation)}
{print}
