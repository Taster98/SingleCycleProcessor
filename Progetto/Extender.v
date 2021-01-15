module Ext(
    output [31:0] ExtImm,
    input [1:0] ImmSrc,
    input [23:0] Istr
);
    //Registro di appoggio
    reg [31:0] r;
    //L'extender ha in input ImmSrc che serve per scegliere che tipo di istruzione ho,
    //e l'Ingr che sarebbe l'ingresso (per le operative 8, per la memoria 12, per i salti 24 bit)
    initial
        begin
            if(ImmSrc[0] == 0 && ImmSrc[1] == 0) //operative, 8 bit:
                r = {24'b0, Istr[7:0]};
            if(ImmSrc[0] == 1 && ImmSrc[1] == 0) //memoria, 12 bit:
                r = {20'b0, Istr[11:0]};
            if(ImmSrc[0] == 0 && ImmSrc[1] == 1) //salti, 24 bit:
                r = {8'b0, Istr[23:0]};
        end
    assign
        ExtImm = r;
endmodule