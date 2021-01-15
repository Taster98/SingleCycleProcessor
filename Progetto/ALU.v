module ALU(
    output [31:0] ALUResult,
    output [3:0] ALUFlags,
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [1:0] ALUControl
);
    //L'alu, in base al controllo che riceve scrive l'operazione risultante:
    reg [31:0] res;
    //qui mi salvo i valori dei flags
    reg [3:0] flags;
    initial
        begin
            if(ALUControl[0] == 0 && ALUControl[1] == 0) //00 ADD
                res = SrcA + SrcB;
            if(ALUControl[0] == 1 && ALUControl[1] == 0) //01 SUB
                res = SrcA - SrcB;
            if(ALUControl[0] == 0 && ALUControl[1] == 1) //10 AND
                res = SrcA & SrcB;
            if(ALUControl[0] == 1 && ALUControl[1] == 1) //11 ORR
                res = SrcA | SrcB;
            if(res == 0)
                flags[3] = 1;
            if(res<0)
                flags[2] = 1;
            if(SrcA >= 2**31-1 && SrcB >= 2**31-1) begin
                //Se entrambi sono maggiori della metà ho un carry sicuramente e anche overflow
                flags[1] = 1;
                flags[0] = 1;   
            end
        end
        assign
            ALUResult = res;
        assign
            ALUFlags = flags;
endmodule