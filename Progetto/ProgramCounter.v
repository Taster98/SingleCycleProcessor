module PC(
    output [31:0] pc,
    input [31:0] pcnext,
    input clk
);
//Lo stato interno è rappresentato dal registro contenente un'istruzione a 32 bit
reg [31:0] istr;

//anche se non è molto intuitivo, inizialmente facciamo che punti all'istruzione di indirizzo 0
initial
    istr = 0;

// Al fronte di salita del ciclo di clock deve cambiare lo stato
always @(posedge clk)
    begin
        istr = pcnext;
    end

// E lo restituisco in output
assign
    pc = istr;
endmodule