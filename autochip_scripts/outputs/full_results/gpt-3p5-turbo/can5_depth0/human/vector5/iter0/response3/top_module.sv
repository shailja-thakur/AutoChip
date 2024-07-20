module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	// Declare internal signals
	wire [4:0] a_b, a_c, a_d, a_e;
	wire [3:0] b_c, b_d, b_e;
	wire [2:0] c_d, c_e;
	wire [1:0] d_e;

	// Assign internal signals
	assign a_b = a ^ b;
	assign a_c = a ^ c;
	assign a_d = a ^ d;
	assign a_e = a ^ e;
	assign b_c = b ^ c;
	assign b_d = b ^ d;
	assign b_e = b ^ e;
	assign c_d = c ^ d;
	assign c_e = c ^ e;
	assign d_e = d ^ e;

	// Assign output bits
	assign out[24] = ~a ^ a;
	assign out[23] = ~a ^ b;
	assign out[22] = ~a ^ c;
	assign out[21] = ~a ^ d;
	assign out[20] = ~a ^ e;
	assign out[19] = ~b ^ a;
	assign out[18] = ~b ^ b;
	assign out[17] = ~b ^ c;
	assign out[16] = ~b ^ d;
	assign out[15] = ~b ^ e;
	assign out[14] = ~c ^ a;
	assign out[13] = ~c ^ b;
	assign out[12] = ~c ^ c;
	assign out[11] = ~c ^ d;
	assign out[10] = ~c ^ e;
	assign out[9] = ~d ^ a;
	assign out[8] = ~d ^ b;
	assign out[7] = ~d ^ c;
	assign out[6] = ~d ^ d;
	assign out[5] = ~d ^ e;
	assign out[4] = ~e ^ a;
	assign out[3] = ~e ^ b;
	assign out[2] = ~e ^ c;
	assign out[1] = ~e ^ d;
	assign out[0] = ~e ^ e;
	
endmodule
