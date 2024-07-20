module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
wire [24:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] neg_a_vec, neg_b_vec, neg_c_vec, neg_d_vec, neg_e_vec;

// Generate 5-bit vectors from the input signals
assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

// Concatenate the 5-bit vectors into 25-bit vectors
assign a_vec = {a_bits, a_bits, a_bits, a_bits, a_bits};
assign b_vec = {b_bits, b_bits, b_bits, b_bits, b_bits};
assign c_vec = {c_bits, c_bits, c_bits, c_bits, c_bits};
assign d_vec = {d_bits, d_bits, d_bits, d_bits, d_bits};
assign e_vec = {e_bits, e_bits, e_bits, e_bits, e_bits};

// Compute the negated vectors
assign neg_a_vec = ~a_vec;
assign neg_b_vec = ~b_vec;
assign neg_c_vec = ~c_vec;
assign neg_d_vec = ~d_vec;
assign neg_e_vec = ~e_vec;

// Compute the XOR of the negated vectors and the original vectors
assign out = neg_a_vec ^ a_vec ^
              neg_b_vec ^ b_vec ^
              neg_c_vec ^ c_vec ^
              neg_d_vec ^ d_vec ^
              neg_e_vec ^ e_vec;

endmodule
