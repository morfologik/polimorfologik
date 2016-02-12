INFORMACJA
==========

Morfologik to projekt tworzenia polskich słowników morfosyntaktycznych (stąd 
nazwa) służących do znakowania morfosyntaktycznego i syntezy gramatycznej.

WERSJA: $v
UTWORZONA: $build


ŹRÓDŁO
======

Dane pochodzą ze słownika sjp.pl oraz słownika PoliMorf i są licencjonowane na 
licencji zawartej w pliku LICENSE.Polish.txt. Dane źródłowe pochodzą z 
polskiego słownika ispell, następnie redagowanego na stronach 
kurnik.pl/slownik i sjp.pl, a także Słownika Gramatycznego Języka Polskiego. 

Autorzy:

  (1) ispell: Mirosław Prywata, Piotr Gackiewicz, Włodzimierz Macewicz, 
      Łukasz Szałkiewicz, Marek Futrega.
  (2) SGJP: Zygmunt Saloni, Włodzimierz Gruszczyński, Marcin Woliński, 
      Robert Wołosz.

Wersja PoliMorf została opracowana w ramach projektu CESAR realizowanego w 
Zespole Inżynierii Lingwistycznej IPI PAN. W przygotowaniu ostatecznej 
wersji 2.0 dopomogli Jan Szejko i Adam Radziszewski.


PLIKI
=====

1. polish.dict to binarny plik słownika dla programu fsa_morph Jana Daciuka 
(zob. [1]), wykorzystywany również bezpośrednio przez korektor gramatyczny 
LanguageTool (zob. [2]) oraz pakiet morfologik-stemming (zob. [3]).

2. polish_synth.dict to binarny plik słownika syntezy gramatycznej,
używany w fsa_morph i LanguageTool. Aby uzyskać formę odmienioną,
należy używać następującej składni w zapytaniu programu fsa_morph:

<wyraz>|<znacznik>

Na przykład:

niemiecki|adjp

daje "niemiecku+".

3. polish.info i polish_synth.info - pliki metadanych wymagane do użycia powyższych 
plików binarnych w bibliotece morfologik-stemming.

[1] http://www.eti.pg.gda.pl/katedry/kiw/pracownicy/Jan.Daciuk/personal/fsa.html
[2] https://languagetool.org/
[3] https://github.com/morfologik/morfologik-stemming


ZNACZNIKI MORFOSYNTAKTYCZNE
===========================

Zestaw znaczników jest zbliżony do zestawu korpusu NKJP (www.nkjp.pl).

    * adj - przymiotnik (np. „niemiecki”)
    * adja - przymiotnik przyprzymiotnikowy (np. „niemiecko”, w wyrażeniach typu „niemiecko-chiński”)
    * adjc - przymiotnik przedykatywny (np. „ciekaw”, „dłużen”)
    * adjp - przymiotnik poprzyimkowy (np. „niemiecku”)
    * adv - przysłówek (np. „głupio”)
    * burk - burkinostka (np. „Burkina Faso”)
    * depr - forma deprecjatywna
    * ger - rzeczownik odsłowny
    * conj - spójnik łączący zdania współrzędne
    * comp - spójnik wprowadzający zdanie podrzędne
    * num - liczebnik
    * pact - imiesłów przymiotnikowy czynny
    * pant - imiesłów przysłówkowy uprzedni
    * pcon - imiesłów przysłówkowy współczesny
    * ppas - imiesłów przymiotnikowy bierny
    * ppron12 - zaimek nietrzecioosobowy
    * ppron3 - zaimek trzecioosobowy
    * pred - predykatyw (np. „trzeba”)
    * prep - przyimek
    * siebie - zaimek "siebie"
    * subst - rzeczownik
    * verb - czasownik
    * brev - skrót
    * interj - wykrzyknienie
    * qub - kublik (np. „nie” lub „tak”)

Atrybuty podstawowych form:

    * sg / pl - liczba pojedyncza / liczba mnoga    
    * nom - mianownik
    * gen - dopełniacz
    * acc - biernik
    * dat - celownik
    * inst - narzędnik
    * loc - miejscownik
    * voc - wołacz
    * pos - stopień równy
    * com - stopień wyższy
    * sup - stopień najwyższy
    * m1, m2, m3 - rodzaje męskie
    * n1, n2 - rodzaje nijakie
    * p1, p2, p3 - rodzaje rzeczowników mających tylko liczbę mnogą (pluralium tantum)
    * f - rodzaj żeński
    * pri - pierwsza osoba
    * sec - druga osoba
    * ter - trzecia osoba
    * aff - forma niezanegowana
    * neg - forma zanegowana
    * refl - forma zwrotna czasownika
    * nonrefl - forma niezwrotna czasownika
    * refl.nonrefl - forma może być zwrotna lub niezwrotna
    * perf - czasownik dokonany
    * imperf - czasownik niedokonany
    * imperf.perf - czasownik, który może występować zarówno jako dokonany, jak i jako niedokonany
    * nakc - forma nieakcentowana zaimka (ppron lub siebie)
    * akc - forma akcentowana zaimka
    * praep - forma poprzyimkowa
    * npraep - forma niepoprzyimkowa
    * ger - rzeczownik odsłowny
    * imps - forma bezosobowa
    * impt - tryb rozkazujący
    * inf - bezokolicznik
    * fin - forma nieprzeszła
    * bedzie - forma przyszła "być"
    * praet - forma przeszła czasownika (pseudoimiesłów)
    * pot - tryb przypuszczający [nie występuje w znacznikach NKJP]
    * pun - skrót z kropką [za NKJP]
    * npun - bez kropki [za NKJP]	
    * wok / nwok: forma wokaliczna / niewokaliczna

Uwaga: formy trybu przypuszczającego są jednolicie oznaczone tylko znacznikiem 
pot, bez znacznika praet.

W znacznikach Morfologika nie występuje i nie będzie występować znacznik 
aglt, a to ze względu na inną zasadę segmentacji wyrazów.
