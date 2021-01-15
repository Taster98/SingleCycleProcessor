module MemData(
    output [31:0] RD,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    input clk
);

//Lo stato interno della memoria dati è data da un array di 32 bit, in totale indirizzabili da 32 bit quindi
// 2**32:
reg [31:0] data [0:2**32-1];
//indice per inizializzare la memoria a 0
integer i;
//inizializzazione memoria dati, per semplicità tutti 0
initial
    begin
        for(i=0;i<2**32-1;i++)
            data[i] = 0;
    end

//la scrittura in memoria va fatta solo quando il fronte del ciclo di clock è alto e il WE è alto.
always @(posedge clk)
    begin
        if(WE)
            data[A] <= WD; 
    end

//Infine la lettura dalla memoria
assign
    RD = data[A];
endmodule