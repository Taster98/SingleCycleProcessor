module Plus4(
    output [31:0] PCPlus4,
    input [31:0] PC
);
    assign
        PCPlus4 = PC + 4;
endmodule