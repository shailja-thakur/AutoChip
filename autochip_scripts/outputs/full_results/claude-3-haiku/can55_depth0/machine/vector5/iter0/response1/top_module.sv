module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
wire [24:0] inv_a, inv_b, inv_c, inv_d, inv_e, combined;

// Create the 5-bit vectors
assign a_vec = {5{a}};
assign b_vec = {5{b}};
assign c_vec = {5{c}};
assign d_vec = {5{d}};
assign e_vec = {5{e}};

// Invert the 5-bit vectors
assign inv_a = ~{a_vec};
assign inv_b = ~{b_vec};
assign inv_c = ~{c_vec};
assign inv_d = ~{d_vec};
assign inv_e = ~{e_vec};

// Combine the inverted 5-bit vectors into a 25-bit vector
assign combined = {inv_a, inv_b, inv_c, inv_d, inv_e};

// Compute the bitwise exclusive-OR of the two 25-bit vectors
assign out = combined ^ {5{a,b,c,d,e}};

endmodule
