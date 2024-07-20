module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	/* compute the first 25-bit vector */
	wire [24:0] not_a = ~{ {5{a}} };
	wire [24:0] not_b = ~{ {5{b}} };
	wire [24:0] not_c = ~{ {5{c}} };
	wire [24:0] not_d = ~{ {5{d}} };
	wire [24:0] not_e = ~{ {5{e}} };

	/* compute the second 25-bit vector */
	wire [24:0] a_vec = {5{a}};
	wire [24:0] b_vec = {5{b}};
	wire [24:0] c_vec = {5{c}};
	wire [24:0] d_vec = {5{d}};
	wire [24:0] e_vec = {5{e}};

	/* compute the bitwise exclusive-or */
	assign out = not_a ^ a_vec ^ not_b ^ b_vec ^ not_c ^ c_vec ^ not_d ^ d_vec ^ not_e ^ e_vec;

endmodule
