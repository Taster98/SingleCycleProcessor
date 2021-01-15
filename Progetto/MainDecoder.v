module MainDecoder(
    output Branch,
    output MemtoReg,
    output MemW,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegW,
    output RegSrc,
    output ALUOp,
    input [1:0] Op,
    input funct5,
    input funct0
    );
    reg b, memreg, memw, alusrc, regw, aluop, regsrc;
    reg [1:0] immsrc;
    initial
        begin
            if(Op == 0) begin
                b = 0;
                memreg = 0;
                memw = 0;
                regw = 1;
                aluop = 1;
                regsrc=0;
                if(funct5 == 1) begin
                    immsrc = 0;
                    alusrc=1;
                end
                else
                    alusrc=0;
            end
            else if(Op == 1) begin
                b = 0;
                alusrc = 1;
                immsrc = 1;
                aluop = 0;
                regsrc=1;
                if(funct0 == 1) begin
                    memreg = 1;
                    memw=0;
                    regw = 1;
                end
                else begin
                    memw=1;
                    regw=0;
                end
            end
            else if(Op==2) begin
                b=1;
                memreg = 0;
                memw=0;
                alusrc = 1;
                immsrc = 2;
                regw=0;
                regsrc=1;
                aluop=0;
            end
        end
        assign
            Branch = b;
        assign
            MemtoReg = memreg;
        assign
            MemW = memw;
        assign
            ALUSrc = alusrc;
        assign
            ImmSrc = immsrc;
        assign
            RegW = regw;
        assign
            RegSrc = regsrc;
        assign
            ALUOp = aluop;
endmodule