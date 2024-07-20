module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] input_vec, inv_vec;

// Generate the 25-bit vectors for each input
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Concatenate the input vectors
assign input_vec = {a_vec, b_vec, c_vec, d_vec, e_vec};

// Invert the input vectors
assign inv_vec = ~input_vec;

// Compute the bitwise XOR of the two 25-bit vectors
assign out = inv_vec ^ input_vec;

endmodule
