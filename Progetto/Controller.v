module Controller(
    output RegSrc,
    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output MemtoReg,
    output PCSrc,
    output [1:0] ALUControl,
    output [1:0] ImmSrc,
    input [3:0] ALUFlags,
    input [31:12] Instr,
    input clock
    );
endmodule