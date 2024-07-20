module top_module(
    input [7:0] p1,
    input [7:0] p2,
    output p1y,
    output p2y
);

    wire [3:0] nand1;
    wire [3:0] nand2;
    
    // First 4-input NAND gate
    assign nand1[0] = ~(p1[0] & p1[1] & p1[2] & p1[3]);
    assign nand1[1] = ~(p1[4] & p1[5] & p1[6] & p1[7]);
    
    // Second 4-input NAND gate
    assign nand2[0] = ~(p2[0] & p2[1] & p2[2] & p2[3]);
    assign nand2[1] = ~(p2[4] & p2[5] & p2[6] & p2[7]);

    // Outputs
    assign p1y = ~(nand1[0] & nand1[1]);
    assign p2y = ~(nand2[0] & nand2[1]);

endmodule
