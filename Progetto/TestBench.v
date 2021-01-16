module test();
    //Il ciclo di clock
    reg clock;
    reg [31:0] WriteData, DataAdr;
    wire [31:0] PCNext; //Istruzione successiva
    always 
        begin
            clock<=1;
            #5;
            clock<=0;
            #5;
        end
    //Istanzio il processore
    Processore singleCycle(PCNext,0,clock); //Parto da istruzione 0
    initial
        begin
            $dumpfile("test_arm.vcd");
            $dumpvars;

            DataAdr = 15;
            WriteData = 17;

            #25 $finish;
        end
endmodule