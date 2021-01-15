module ALUDecoder(
    output [1:0] ALUControl,
    output [1:0] FlagW,
    input [4:0] Funct,
    input ALUOp
);
    reg [1:0] aluctl;
    reg [1:0] flagctl;
    initial
        begin
            if(ALUOp) begin
                if(Funct[4] == 0) begin
                    if(Funct[3] == 0) begin
                        if(Funct[2] == 0 && Funct[1] == 0) begin //AND
                            if(Funct[0] == 0) begin
                                 // NON S
                                aluctl[1] = 1;
                                aluctl[0] = 0;
                                flagctl[1] = 0;
                                flagctl[0] = 0;
                            end
                            else if(Funct[0] == 1) begin
                                aluctl[1] = 1;
                                aluctl[0] = 0;
                                flagctl[1] = 1;
                                flagctl[0] = 0;
                            end
                        end
                        else if(Funct[2] == 1 && Funct[1]==0) begin //SUB
                            if(Funct[0] == 0) begin
                                aluctl[1] = 0;
                                aluctl[0] = 1;
                                flagctl[1] = 0;
                                flagctl[0] = 0;
                            end
                            else if(Funct[0] == 1) begin
                                aluctl[1] = 0;
                                aluctl[0] = 1;
                                flagctl[1] = 1;
                                flagctl[0] = 1;
                            end
                        end
                    end
                    else if(Funct[3] == 1 && Funct[2] == 0 && Funct[1] == 0) begin//ADD
                        if(Funct[0] == 0) begin
                            aluctl[1] = 0;
                            aluctl[0] = 0;
                            flagctl[1] = 0;
                            flagctl[0] = 0;
                        end
                        else if(Funct[0] == 1) begin
                            aluctl[1] = 0;
                            aluctl[0] = 0;
                            flagctl[1] = 1;
                            flagctl[0] = 1;
                        end
                    end
                end
                else if (Funct[4] == 1 && Funct[3] == 1 && Funct[2] == 0 && Funct[1] == 0) begin  //ORR
                    if(Funct[0] == 0) begin
                        aluctl[1] = 1;
                        aluctl[0] = 1;
                        flagctl[1] = 0;
                        flagctl[0] = 0;
                    end
                    else if(Funct[0] == 1) begin
                        aluctl[1] = 1;
                        aluctl[0] = 1;
                        flagctl[1] = 1;
                        flagctl[0] = 0;
                    end
                end
            end
        end
        assign
            ALUControl = aluctl;
        assign
            FlagW = flagctl;
endmodule