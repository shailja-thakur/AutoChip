module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire n1; // NAND gate 1 output
    wire n2; // NAND gate 2 output
    
    // NAND gate 1
    assign n1 = ~(p1[0] & p1[1] & p1[2] & p1[3]);
    
    // NAND gate 2
    assign n2 = ~(p2[0] & p2[1] & p2[2] & p2[3]);
    
    // Output assignments
    assign p1y = n1;
    assign p2y = n2;

endmodule
