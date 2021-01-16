module stato(
    output PCSrc,
    output RegWrite,
    output MemWrite,
    input [3:0] ALUFlags,
    input [3:0] Cond,
    input [1:0] FlagW,
    input PCS,
    input RegW,
    input MemW,
    input clk
);
    reg [3:0] NZCV; //Rappresenta lo stato interno
    wire CondEx; //Rappresenta le condizioni
    reg [1:0] FlagWrite; //Rappresenta la scrittura dei flag
    initial
        NZCV = 0;

    always @(posedge clk)
        begin
            NZCV <= ALUFlags;
        end
    //Stabilizzo la condizione
    condcheck condc(CondEx, Cond, NZCV);
    initial FlagWrite = FlagW & {2{CondEx}};
    assign RegWrite = RegW & CondEx;
    assign MemWrite = MemW & CondEx;
    assign PCSrc = PCS & CondEx;
endmodule

module condcheck(
    output CondEx,
    input [3:0] Cond,
    input [3:0] NZCV
);
reg neg, zero, carry, overflow, ge, cnd; 

initial
    begin
        {neg,zero,carry,overflow} = NZCV;
        ge = (neg==overflow);
        case(Cond)
            4'b0000: cnd = zero; //EQ
            4'b0001: cnd = ~zero; //NE
            4'b0010: cnd = carry; //CS
            4'b0011: cnd = ~carry; //CC
            4'b0100: cnd = neg; //MI
            4'b0101: cnd = ~neg; //PL
            4'b0110: cnd = overflow; //VS
            4'b0111: cnd = ~overflow; //VC
            4'b1000: cnd = carry & ~zero; //HI
            4'b1001: cnd = ~(carry & ~zero); //LS
            4'b1010: cnd = ge; //GE
            4'b1011: cnd = ~ge; //LT
            4'b1100: cnd = ~zero & ge; //GT
            4'b1101: cnd = ~(~zero & ge); //LE
            4'b1110: cnd = 1'b1; //Always
            default: cnd = 1'bx; //undefined
        endcase
    end
    assign
        CondEx = cnd;
endmodule