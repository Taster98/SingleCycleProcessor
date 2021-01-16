module ARM(
    output [31:0] PC,
    output [31:0] ALUResult,
    output [31:0] WriteData,
    output MemWrite,
    input [31:0] ReadData,
    input [31:0] Instr,
    input clk
);
    Controller c();
    Datapath dp();
endmodule