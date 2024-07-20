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

// Internal wires
wire p1nand1_out;
wire p1nand2_out;
wire p2nand1_out;
wire p2nand2_out;

// 4-input NAND gates
nand4 p1nand1(p1a, p1b, p1c, p1d, p1nand1_out);
nand4 p1nand2(p1a, p1b, p1c, p1d, p1nand2_out);
nand4 p2nand1(p2a, p2b, p2c, p2d, p2nand1_out);
nand4 p2nand2(p2a, p2b, p2c, p2d, p2nand2_out);

// Output assignment
assign p1y = p1nand1_out;
assign p2y = p2nand1_out;

endmodule
