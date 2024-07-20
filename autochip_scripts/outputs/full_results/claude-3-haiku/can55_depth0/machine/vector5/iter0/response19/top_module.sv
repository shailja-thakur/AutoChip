module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] not_a, not_b, not_c, not_d, not_e;
wire [24:0] a_b_c_d_e;

// Generate 5-bit vectors from the input signals
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Invert the 5-bit vectors
assign not_a = ~{a_vec};
assign not_b = ~{b_vec};
assign not_c = ~{c_vec};
assign not_d = ~{d_vec};
assign not_e = ~{e_vec};

// Concatenate the inverted 5-bit vectors
assign a_b_c_d_e = {not_a, not_b, not_c, not_d, not_e};

// Compute the bitwise XOR of the two 25-bit vectors
assign out = a_b_c_d_e ^ {5{a,b,c,d,e}};

endmodule
