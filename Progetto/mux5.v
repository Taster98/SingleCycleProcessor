module mux5(
    output [3:0] RA1,
    input RegSrc,
    input [3:0] Istr
);
    assign
        SrcB = (RegSrc == 0) ? Istr : 15;
endmodule