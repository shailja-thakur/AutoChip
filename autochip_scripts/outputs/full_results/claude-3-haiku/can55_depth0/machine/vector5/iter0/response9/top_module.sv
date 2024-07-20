module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] not_vec, and_vec;

// Replicate the input signals into 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Create the two 25-bit vectors
assign not_vec = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
assign and_vec = {a_vec, b_vec, c_vec, d_vec, e_vec};

// Compute the bitwise XOR of the two vectors
assign out = not_vec ^ and_vec;

endmodule
