{

#adj:sg:acc.gen:m1:pos:aff+adj:sg:acc:m2.m3.n:pos:aff+adj:sg:gen:n:pos:aff
#remove the second one, move m3 to gen:n
gsub("+adj:sg:acc:m2.m3.n(:pos:aff|:comp|:sup)?\+?","") #remove completely
gsub("adj:sg:acc.gen:m1","adj:sg:acc.gen:m1.m2") #move m2
gsub("adj:sg:gen:n","adj:sg:gen:m3.n") #move m3

#ppas:sg:gen:m2.m3.n+ppas:sg:acc.gen:m1
#same for ppas
gsub("ppas:sg:acc.gen:m1","ppas:sg:acc.gen:m1.m2") #move m2
gsub("ppas:sg:gen:m2.m3.n","ppas:sg:gen:m3.n") #remove m2

#pact:sg:gen:m2.m3.n:aff+pact:sg:acc.gen:m1:aff
gsub("pact:sg:acc.gen:m1","pact:sg:acc.gen:m1.m2") #move m2
gsub("pact:sg:gen:m2.m3.n","pact:sg:gen:m3.n") #remove m2

print
}