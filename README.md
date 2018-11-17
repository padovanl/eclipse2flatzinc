# eclipse2flatzinc

Per utilizzare la libreria, sustituire sul file .ecl o .pl di cui si vogliono tradurre i vincoli in flatzinc l'istruzione
```
:-lib(fd).
```
con:
```
:-[libreria].
```
Al termine dell'esecuzione, il modello flatzinc corrispondente viene creato nel file model.fzn. Questo modello può essere eseguito da un terminale ECLiPSe caricando la libreria flatzinc con il comando:
```
lib(flatzinc).
```
e successivamente lanciando il solver tramite:
```
fzn_run("model.fzn",fzn_ic).
```

## Requisiti
Per motivi implementativi, e per far funzionare bene la libreria, occorre che tra la definizione della variabile e l'uso del vincolo non siano dichiarate altre variabili. 

## File di prova
Nella cartella samples sono disponibili esempi pronti per essere convertiti in flatzinc. I file prendono il nome secondo la regola:
```
nome_vincolo.ecl
```
Una volta caricato il file tramite il comando
```
:-[nome_vincolo]
```
in Tkeclipse digitare:
```
sample.
```
per convertire il codice nel rispettivo modello flatzinc.

## Vincoli supportati
La libreria supporta i principali vincoli affrontati a lezione delle librerie fd e fd_global:
- =
- \\=
- <
- <=
- \>
- \>=
- alldifferent
- atleast
- atmost
- occurrences
- element
- maxlist
- minlist
- sorted (ma non funziona, neanche convertito da minizinc)

## Vincoli non ancora supportati
La libreria al momento non supporta ancora i seguenti vincoli:
- lexico_le
- flatten
- sumlist
- cumulative
- minimize
