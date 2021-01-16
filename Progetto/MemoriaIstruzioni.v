module MemIstr(
    output [31:0] RD,
    input [31:0] PC
);
//Lo stato interno è rappresentato da un vettore di istruzioni a 32 bit, per semplicità ne mettiamo 128 di istruzioni.
reg [31:0] data [1:0];

//Per semplicità, inizializiamo il nostro "data" leggendo da un file di testo le istruzioni riga per riga
initial
    $readmemh("istruzioni.dat",data, 0, 0);

//Abbiamo detto che noi in questa memoria non facciamo altro che dare in output l'istruzione all'indirizzo pc:
assign
    RD = data[PC[31:2]];
endmodule