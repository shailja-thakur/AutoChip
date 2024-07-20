module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    output p2y,
    input p2a,
    input p2b,
    input p2c,
    input p2d
);

    wire p1_nand_out;
    wire p2_nand_out;

    assign p1_nand_out = ~(p1a & p1b & p1c & p1d);
    assign p2_nand_out = ~(p2a & p2b & p2c & p2d);
    
    assign p1y = p1_nand_out;
    assign p2y = p2_nand_out;
    
endmodule
