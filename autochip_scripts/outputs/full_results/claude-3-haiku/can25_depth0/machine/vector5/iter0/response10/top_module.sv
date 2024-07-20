module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] xor_vec, and_vec;

// Generate 5-bit vectors from inputs
assign a_vec = {5{~a}};
assign b_vec = {5{~b}};
assign c_vec = {5{~c}};
assign d_vec = {5{~d}};
assign e_vec = {5{~e}};

// Generate 25-bit vectors
assign xor_vec = {a_vec, b_vec, c_vec, d_vec, e_vec};
assign and_vec = {5{a, b, c, d, e}};

// Compute the bitwise XOR
assign out = xor_vec ^ and_vec;

endmodule
