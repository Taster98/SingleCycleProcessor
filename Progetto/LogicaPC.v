module PCLogic(
    output PCS,
    input [3:0] Rd,
    input Branch,
    input RegW
);
    assign
        PCS = ((Rd==15) & RegW) | Branch;
endmodule