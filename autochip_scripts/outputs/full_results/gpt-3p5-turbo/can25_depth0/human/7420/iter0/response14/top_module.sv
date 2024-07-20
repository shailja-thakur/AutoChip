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

// Define internal wires
wire w1, w2, w3, w4;

// Implement the first NAND gate
assign w1 = ~(p1a & p1b & p1c & p1d);

// Implement the second NAND gate
assign w2 = ~(p2a & p2b & p2c & p2d);

// Assign outputs
assign p1y = w1;
assign p2y = w2;

endmodule
