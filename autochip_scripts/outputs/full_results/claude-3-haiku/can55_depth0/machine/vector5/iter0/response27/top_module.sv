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

// Generate the 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Generate the 25-bit vectors
assign not_a = {25{~a}};
assign not_b = {25{~b}};
assign not_c = {25{~c}};
assign not_d = {25{~d}};
assign not_e = {25{~e}};

// Combine the 25-bit vectors
assign a_b_c_d_e = {5{a,b,c,d,e}};

// Compute the XOR
assign out = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ a_b_c_d_e;

endmodule
