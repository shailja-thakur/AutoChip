module top_module(
    input [3:0] p1a, 
    input [3:0] p1b, 
    input [3:0] p1c, 
    input [3:0] p1d, 
    output p1y, 
    input [3:0] p2a, 
    input [3:0] p2b, 
    input [3:0] p2c, 
    input [3:0] p2d, 
    output p2y
);

// Define the wires for intermediate signals
wire nand1;
wire nand2;

// Implement the 4-input NAND gates
assign nand1 = ~(p1a & p1b & p1c & p1d);
assign nand2 = ~(p2a & p2b & p2c & p2d);

// Assign the outputs
assign p1y = nand1;
assign p2y = nand2;

endmodule
