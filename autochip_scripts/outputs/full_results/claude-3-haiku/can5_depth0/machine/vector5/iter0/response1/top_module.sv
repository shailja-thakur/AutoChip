module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] inv_a, inv_b, inv_c, inv_d, inv_e;
wire [24:0] pos_a, pos_b, pos_c, pos_d, pos_e;

// Create 5-bit vectors from the input signals
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Create 25-bit vectors with inverted input signals
assign inv_a = {5{~a}};
assign inv_b = {5{~b}};
assign inv_c = {5{~c}};
assign inv_d = {5{~d}};
assign inv_e = {5{~e}};

// Create 25-bit vectors with positive input signals
assign pos_a = {5{a}};
assign pos_b = {5{b}};
assign pos_c = {5{c}};
assign pos_d = {5{d}};
assign pos_e = {5{e}};

// Compute the bitwise exclusive-or of the two 25-bit vectors
assign out = (inv_a ^ pos_a) ^ (inv_b ^ pos_b) ^ (inv_c ^ pos_c) ^ (inv_d ^ pos_d) ^ (inv_e ^ pos_e);

endmodule
