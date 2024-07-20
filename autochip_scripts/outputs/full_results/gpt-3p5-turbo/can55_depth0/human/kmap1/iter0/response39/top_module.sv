module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	// combinational logic
	assign out = (~a & ~b & c) | (a & b & c);
	
endmodule
