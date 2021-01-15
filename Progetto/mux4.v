module mux4(
    output [31:0] SrcB,
    input ALUSrc,
    input [31:0] RD2,
    input [31:0] Imm
);
    assign
        SrcB = (ALUSrc==0) ? RD2 : Imm;
endmodule