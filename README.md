PoliMorfologik
==============

Morfologik is a project aiming at generating Polish morphosyntactic dictionaries (hence the name) used for part-of-speech tagging and
part-of-speech synthesis. The PoliMorfologik dictionary is a result of the [PoliMorf project](http://zil.ipipan.waw.pl/PoliMorf). It contains around It over 215 thousand lexemes and around 3.5 million word forms.

The dictionary was created by enriching the Polish ispell/hunspell dictionary with morphological information, which was possible thanks to the structure of the original dictionary that retained important grammatical distinctions. The process of conversion relied on a series of scripts, and the resulting dictionary was later augmented with manually entered information. Unfortunately, the original source dictionary did not contain sufficient structure to allow reliable detection of some information, such as the exact subgender of the masculine for substantives. This information was added manually and using heuristic methods, however its reliability is low. Considering the fact that the substantives are about one third of the dictionary content (and almost half of them are masculine), this limitation is severe.

The tagset of the dictionary is inspired by the IPI PAN Tagset. However, Morfologik diverges from that tagset and from Morfeusz, as it never splits orthographic (“space-to-space”) words into smaller dictionary words (i.e. so-called agglutination is not considered). Moreover, due to the lack of information in the ispell dictionary, some forms are not completely annotated, and are marked as irregular. There is, however, some additional mark up added to reflexive verbs, which is not present in the original IPI PAN Tagset. This was introduced for the purposes of the grammar checker [LanguageTool](http://languagetool.org) that used the dictionary extensively.

The dictionaries can be used with [morfologik-stemming library and tools](https://github.com/morfologik/morfologik-stemming). 

See [src/LICENSE.txt](src/LICENSE.txt) for license information. Basically, it's BSD.
