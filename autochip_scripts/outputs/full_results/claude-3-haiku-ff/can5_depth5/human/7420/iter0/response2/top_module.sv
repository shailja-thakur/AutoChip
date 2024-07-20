module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    output p1y,
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d,
    output p2y
);

    // Gate 1
    wire p1_nand;
    assign p1_nand = ~(p1a & p1b & p1c & p1d);
    assign p1y = p1_nand;

    // Gate 2
    wire p2_nand;
    assign p2_nand = ~(p2a & p2b & p2c & p2d);
    assign p2y = p2_nand;

endmodule
