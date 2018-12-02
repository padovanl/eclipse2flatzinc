# eclipse2flatzinc

## Flatzinc
> FlatZinc is the target constraint modelling language into which MiniZinc models are translated.  It
is a very simple solver independent problem specification language, requiring minimal implementation effort to support.

Lo scopo di questa libreria è di effettuare la traduzioni dei vincoli utilizzati da un programma che usa la libreria fd in un modello flatzinc. Anche se inizialmente lo scopo era di tradurre i vincoli della libreria fd, successivamente ho aggiunto alcuni semplici vincoli della libreria fd_global.

Per approfondire la conoscenza con flatzinc, è possibile consultare le [Specifiche di flatzinc](https://www.minizinc.org/downloads/doc-1.3/flatzinc-spec.pdf).

## Istruzioni
Per utilizzare la libreria, sustituire sul file .ecl o .pl di cui si vogliono tradurre i vincoli in flatzinc le istruzioni
```
:-lib(fd).
:-lib(fd_global).
```
con:
```
:-[eclipse2flatzinc].
```
Al termine dell'esecuzione, il modello flatzinc corrispondente viene creato nel file model.fzn. Questo modello può essere eseguito da un terminale ECLiPSe caricando la libreria flatzinc con il comando:
```
lib(flatzinc).
```
e successivamente lanciando il solver tramite:
```
fzn_run("model.fzn",fzn_ic).
```
**Nota** Prima di procedere ad effettuare una nuova traduzione, occorre eliminare il file model.fzn eventualmente creato precedentemente.

## Requisiti
Per motivi implementativi occorre che tra la definizione della variabile e l'uso del vincolo non siano dichiarate altre variabili. 

## Esempi
Nella cartella samples sono disponibili esempi pronti per essere convertiti in flatzinc. I file prendono il nome secondo la regola:
```
nome_vincolo.ecl
```
Una volta caricato il file tramite il comando
```
:-[nome_vincolo].
```
in Tkeclipse digitare:
```
nome_predicato_sample.
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
- sumlist
- sorted (ma non funziona, neanche convertito da minizinc)

## Vincoli non ancora supportati
La libreria al momento non supporta ancora i seguenti vincoli:
- lexico_le
