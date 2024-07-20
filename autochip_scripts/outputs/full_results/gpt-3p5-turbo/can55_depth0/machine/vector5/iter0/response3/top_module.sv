module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// Create a wire for the inverse of each input signal
	wire a_inv = ~a;
	wire b_inv = ~b;
	wire c_inv = ~c;
	wire d_inv = ~d;
	wire e_inv = ~e;

	// Create a wire for each 5-bit segment of the inverse vector
	wire [4:0] a_inv_5 = {a_inv, a_inv, a_inv, a_inv, a_inv};
	wire [4:0] b_inv_5 = {b_inv, b_inv, b_inv, b_inv, b_inv};
	wire [4:0] c_inv_5 = {c_inv, c_inv, c_inv, c_inv, c_inv};
	wire [4:0] d_inv_5 = {d_inv, d_inv, d_inv, d_inv, d_inv};
	wire [4:0] e_inv_5 = {e_inv, e_inv, e_inv, e_inv, e_inv};

	// Create a wire for each 5-bit segment of the input vector
	wire [4:0] a_5 = {a, a, a, a, a};
	wire [4:0] b_5 = {b, b, b, b, b};
	wire [4:0] c_5 = {c, c, c, c, c};
	wire [4:0] d_5 = {d, d, d, d, d};
	wire [4:0] e_5 = {e, e, e, e, e};

	// Create a wire for the exclusive-or between the inverse and input vectors
	wire [24:0] xor_result = a_inv_5 ^ a_5 ^ b_inv_5 ^ b_5 ^ c_inv_5 ^ c_5 ^ d_inv_5 ^ d_5 ^ e_inv_5 ^ e_5;

	// Assign the xor_result wire to the output signal
	assign out = xor_result;

endmodule
