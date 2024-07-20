module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

wire [4:0] a_rep, b_rep, c_rep, d_rep, e_rep;
assign a_rep = {5{~a}};
assign b_rep = {5{~b}};
assign c_rep = {5{~c}};
assign d_rep = {5{~d}};
assign e_rep = {5{~e}};

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

wire [4:0] xor_vec;
assign xor_vec = ~(a_rep & a_vec) ^ (b_rep & b_vec) ^ (c_rep & c_vec) ^ (d_rep & d_vec) ^ (e_rep & e_vec);

assign out = {xor_vec[0], xor_vec[1], xor_vec[2], xor_vec[3], xor_vec[4], xor_vec[5], xor_vec[6], xor_vec[7], xor_vec[8], xor_vec[9], xor_vec[10], xor_vec[11], xor_vec[12], xor_vec[13], xor_vec[14], xor_vec[15], xor_vec[16], xor_vec[17], xor_vec[18], xor_vec[19], xor_vec[20], xor_vec[21], xor_vec[22], xor_vec[23], xor_vec[24]};

endmodule
