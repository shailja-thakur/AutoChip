module top_module(
	input a,
	input b,
	output out
);
	assign out = a ^ ~b;    // Implementing XNOR gate using XOR and NOT

endmodule
