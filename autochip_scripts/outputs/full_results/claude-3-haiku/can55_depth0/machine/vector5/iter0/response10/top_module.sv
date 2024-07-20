module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] invert_vec, normal_vec;

// Generate 5-bit vectors from the inputs
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Generate the two 25-bit vectors
assign invert_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
assign normal_vec = {a_vec, b_vec, c_vec, d_vec, e_vec};

// Compute the bitwise XOR of the two 25-bit vectors
assign out = invert_vec ^ normal_vec;

endmodule
