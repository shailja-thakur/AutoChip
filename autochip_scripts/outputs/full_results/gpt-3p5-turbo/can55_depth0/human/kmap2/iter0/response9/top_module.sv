module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Define internal wire signals
	wire m0, m1, m2, m3;
	
	// Logic gates implementation
	assign m0 = ~a & ~b & ~c & d;
	assign m1 = ~a & ~b & c & d;
	assign m2 = a & b & ~c & ~d;
	assign m3 = a & b & c & ~d;
	
	// Output assignment
	assign out = m0 | m1 | m2 | m3;

endmodule
