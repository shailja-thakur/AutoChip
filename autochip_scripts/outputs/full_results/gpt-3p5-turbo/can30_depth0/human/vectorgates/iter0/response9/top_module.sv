module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	
	// Wire declaration
	wire [2:0] a_inv;
	wire [2:0] b_inv;
	
	// Invert vectors a and b
	not_gate U1(a[0], a_inv[0]);
	not_gate U2(a[1], a_inv[1]);
	not_gate U3(a[2], a_inv[2]);
	
	not_gate U4(b[0], b_inv[0]);
	not_gate U5(b[1], b_inv[1]);
	not_gate U6(b[2], b_inv[2]);
	
	// Bitwise-OR of vectors a and b
	or_gate O1(a, b, out_or_bitwise);
	
	// Logical-OR of vectors a and b
	or_gate O2(out_or_bitwise[0], out_or_bitwise[1], out_or_logical);
	or_gate O3(out_or_logical, out_or_bitwise[2], out_or_logical);
	
	// Assign the inverted vectors to out_not
	assign out_not[2] = b_inv[2];
	assign out_not[3] = b_inv[1];
	assign out_not[4] = b_inv[0];
	assign out_not[5] = a_inv[2];
	assign out_not[6] = a_inv[1];
	assign out_not[7] = a_inv[0];
	
endmodule
