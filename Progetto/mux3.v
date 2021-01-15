module mux3(
    output [3:0] RA2,
    input RegSrc,
    input [3:0] Rm,
    input [3:0] Imm
);
    assign
        RA2 = (RegSrc==0) ? Rm : Imm;
endmodule