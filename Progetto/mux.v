module mux(
    output [31:0] PCNext,
    input PCSrc,
    input [31:0] PCPlus4,
    input [31:0] PCExt
);
    assign
        PCNext = (PCSrc==0) ? PCPlus4 : PCExt;
endmodule