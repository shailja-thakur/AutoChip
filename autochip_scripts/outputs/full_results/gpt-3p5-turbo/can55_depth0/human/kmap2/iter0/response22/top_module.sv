module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Intermediate signals
	wire a_bar, b_bar, c_bar, d_bar;
	wire temp1, temp2, temp3, temp4;
	
	// Signal assignments
	assign a_bar = ~a;
	assign b_bar = ~b;
	assign c_bar = ~c;
	assign d_bar = ~d;
	
	// Circuit implementation
	assign temp1 = a_bar & b_bar;
	assign temp2 = c & d_bar;
	assign temp3 = a & b;
	assign temp4 = c_bar & d_bar;
	assign out = temp1 | temp2 | temp3 | temp4;

endmodule
