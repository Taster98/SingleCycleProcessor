module mux2(
    output [31:0] Result,
    input MemtoReg,
    input [31:0] ReadData,
    input [31:0] ALUResult
);
    assign
        Result = (MemtoReg==0) ? ALUResult : ReadData;
endmodule