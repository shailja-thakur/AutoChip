module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] neg_a, neg_b, neg_c, neg_d, neg_e;
wire [24:0] a_pos, b_pos, c_pos, d_pos, e_pos;

// Create the 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Create the 25-bit negated vectors
assign neg_a = ~{a_vec, a_vec, a_vec, a_vec, a_vec};
assign neg_b = ~{b_vec, b_vec, b_vec, b_vec, b_vec};
assign neg_c = ~{c_vec, c_vec, c_vec, c_vec, c_vec};
assign neg_d = ~{d_vec, d_vec, d_vec, d_vec, d_vec};
assign neg_e = ~{e_vec, e_vec, e_vec, e_vec, e_vec};

// Create the 25-bit positive vectors
assign a_pos = {a_vec, a_vec, a_vec, a_vec, a_vec};
assign b_pos = {b_vec, b_vec, b_vec, b_vec, b_vec};
assign c_pos = {c_vec, c_vec, c_vec, c_vec, c_vec};
assign d_pos = {d_vec, d_vec, d_vec, d_vec, d_vec};
assign e_pos = {e_vec, e_vec, e_vec, e_vec, e_vec};

// Compute the output
assign out = neg_a ^ neg_b ^ neg_c ^ neg_d ^ neg_e ^ a_pos ^ b_pos ^ c_pos ^ d_pos ^ e_pos;

endmodule
