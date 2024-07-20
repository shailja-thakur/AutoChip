module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire q;

// Define the combinational circuit
assign q = !(a & b) & (c | (d & b));

endmodule
