module RegisterFile(
    output [31:0] RD1, 
    output [31:0] RD2,
    input [3:0] A1,
    input [3:0] A2,
    input [3:0] A3,
    input [31:0] WD3,
    input [31:0] R15,
    input WE3,
    input clk
);
    //Lo stato interno è appunto rappresentato da un vettore di 16 registri a 32 bit
    reg [31:0] registri [0:15];
    //Questo indice lo uso per inizializzare i registri
    integer i;
    // Questi registri vengono opportunamente scritti e/o letti, pertanto occorre almeno inizializzarli (a 0)
    initial
        begin
            for(i=0;i<16;i++)
                registri[i] = 0;
        end
    //Una volta che mi sono accertato che i registri siano inizializzati opportunamente, noi sappiamo che la scrittura deve essere fatta
    //se e solo se il clock va alto e il WE3 è 1:
    always @(posedge clk)
        begin
            if(WE3)
                registri[A3] <= WD3;
        end
    //Infine, in caso di lettura devo assegnare i due output dei registri letti (i sorgenti):
    assign
        RD1 = registri[A1];
    assign
        RD2 = registri[A2];
endmodule