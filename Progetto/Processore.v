module Processore(
    output [31:0] PCNext,
    input [31:0] PCCur,
    input clk
);
    //Assembliamo tutti i pezzi:
    //Partiamo dai fili di ingresso/uscita della parte dati
    wire [31:0] PCIn;
    wire [31:0] PCOut;
    wire [31:0] PCPlus4;
    wire [31:0] PCPlus8;
    wire [31:0] Instr;
    wire [31:0] SrcA;
    wire [31:0] SrcB;
    wire [31:0] WriteData; //RD2
    wire [31:0] ALUResult;
    wire [31:0] ReadData;
    wire [31:0] Result;
    wire [3:0] ALUFlags;
    wire [3:0] RA2;
    wire [3:0] RA1;

    //Fili della parte controllo
    wire PCSrc;
    wire RegWrite;
    wire [1:0] ALUControl;
    wire MemWrite;
    wire [1:0] ImmSrc;
    wire MemtoReg;
    wire RegSrc;
    wire ALUSrc;
    wire Branch;
    wire ALUOp;
    wire [1:0]FlagW;
    wire PCS;
    wire RegW;
    wire MemW;
    // DATA PATH
    //Mi istanzio intanto i vari pezzetti fatti finora
    //MULTIPLEXER PER SCEGLIERE COME FARE COL PC
    mux MUX1(PCOut,PCSrc,PCPlus4, Result);
    //PROGRAM COUNTER PC
    PC pc(PCOut,PCCur,clk);
    //INSTRUCTION MEMORY
    MemIstr mistr(Instr, PCOut);
    //MULTIPLEXER PER SCEGLIERE IN BASE A ADD O STR
    mux3 MUX3(RA2,RegSrc,Instr[3:0],Instr[15:12]);
    //PCPLUS4 1
    Plus4 minialu1(PCPlus4, PCOut);
    //PCPLUS4 2
    Plus4 minialu2(PCPlus8, PCPlus4);
    //MULTIPLEXER PER SCEGLIERE L'USCITA DALLA MEM DATI
    mux2 MUX2(Result,MemtoReg,ReadData, ALUResult);
    //MULTIPLEXER PER SCEGLIERE TRA PC E [19:16]
    mux5 MUX5(RA1, RegSrc, Instr[19:16]);
    //REGISTER FILE 
    RegisterFile rf(SrcA,WriteData,RA1,RA2,Instr[15:12],Result,PCPlus8,RegWrite,clk);
    //EXTENDER 32 bit
    Ext extender(SrcB,ImmSrc,Instr[23:0]);
    //ALU 
    ALU alu(ALUResult,ALUFlags,SrcA,SrcB,ALUControl);
    //MULTIPLEXER PER SCEGLIERE IL SRCB
    mux4 MUX4(SrcB,ALUSrc, WriteData, SrcB);
    //DATA MEMORY
    MemData mdata(ReadData, ALUResult, WriteData,MemWrite,clk);

    // CONTROL PATH
    //Decoder
    PCLogic pclogic(PCS,Instr[15:12],Branch,RegW);
    MainDecoder mainDec(Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp, Instr[27:26],Instr[25], Instr[20]);
    ALUDecoder aludec(ALUControl, FlagW, Instr[25:21], ALUOp);
    //Logica condizionale
    //Istanzio i flag di stato 
    stato CPSR(PCSrc, RegWrite, MemWrite, ALUFlags, Instr[31:28], FlagW, PCS, RegW, MemW, clk);
endmodule