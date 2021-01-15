# Istruzioni ARMv7
## Introduzione
Le istruzioni ARM, per efficienza e semplicità, hanno tutte la stessa lunghezza (32 bit), anche se magari non a tutti i tipi di istruzione servono tutti i bit.
Fondamentalmente abbiamo 3 tipi di istruzioni:
* <b>Elaborazione dati:</b> ADD, SUB, MUL ...
* <b>Accesso a memoria:</b> LDR, STR, LDRB ...
* <b>Salti:</b> B, BEQ ...

## Istruzioni di elaborazione dati
Queste hanno un primo operando sorgente a registro, un secondo operando sorgente che può essere sia immediato che registro, eventualmente traslato, e un terzo operando di destinazione a registro.

| 31:28 | 27:26 | 25:20 | 19:16 | 15:12 | 11:0 |
| :---: | :---: | :---: | :---: | :---: | :---: |
| cond | op(00) | funct | Rn | Rd | Src2 |


L'operazione che l'istruzione deve svolgere è codificata in <b>op</b> (OPcode) e <b>funct</b>. Il campo <b>cond</b> codifica l'eventuale esecuzione condizionata sulla base dei flag. Per le istruzioni non condizionate si ha <b>cond=1110</b>. Nelle operazioni di elaborazione dati si ha <b>op=00</b>. Gli <b>operandi</b> sono codificati in 3 campi: <b>Rn</b> è il registro del primo operando sorgente, <b>Src2</b> è il secondo operando sorgente, <b>Rd</b> è il registro destinazione. Il Src2 può contenere un immediato da 8 bit oppure un registro o un registro traslato di un registro.
### Funct
| 25 | 24:21 | 20 |
| :---: | :---: | :---: |
| I | cmd | S |

Il bit <b>I</b> vale 1 quando il campo Src2 è immediato, <b>S</b> vale 1 quando l'istruzione setta i flag di condizione (es. ADDS). I bit <b>cmd</b> invece codificano il comando.

## Istruzioni di accesso a memoria
Queste hanno 3 operandi: un registro di base, uno spiazzamento (offset) che può essere un immediato o un registro eventualmente traslato, e un ulteriore registro che è la destinazione per le operazioni di LDR oppure un'altra sorgente per le operazioni di STR.

| 31:28 | 27:26 | 25:20 | 19:16 | 15:12 | 11:0 |
| :---: | :---: | :---: | :---: | :---: | :---: |
| cond | op(01) | funct | Rn | Rd | Src2 |

A differenza di quelle operative, qui il funct è diviso in 6 e il Src2 può essere un immediato da 12 bit oppure un registro eventualmente traslato di una costante. Funct è composto da <b>I, P, U, B, W, L</b>. <b>I e U</b> determinano se lo spiazzamento è un immediato o un registro e se deve essere sommato o sottratto. <b>P e W</b> specificano il modo di gestione indice. <b>L e B</b> specificano il tipo di accesso in memoria.

## Istruzioni di salto
Queste usano uno spiazzamento immediato di salto a 24 bit.

| 31:28 | 27:26 | 25:24 | 23:0 |
| :---: | :---: | :---: | :---: |
| cond | op(10) | 1L(funct) | imm24|

Anche qui abbiamo cond che indica se è un salto condizionato, e i due bit di op che ci dicono che è un'operazione di salto. Il <b>funct</b> è da soli 2 bit: il primo è sempre 1, il secondo dice il tipo di salto <i>Branch o Branch and Link</i>. L'immediato <b>imm24</b> contiene l'indirizzo dell'istruzione che viene esteso a 32 bit traslandolo a sinistra di 2 pposizioni e sommando PC + 8.