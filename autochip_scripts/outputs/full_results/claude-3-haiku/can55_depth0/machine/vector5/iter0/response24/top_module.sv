module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] vec1, vec2;

// Generate 5-bit vectors from the input signals
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Create the two 25-bit vectors
assign vec1 = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
assign vec2 = {5{a, b, c, d, e}};

// Compute the bitwise XOR of the two vectors
assign out = vec1 ^ vec2;

endmodule
