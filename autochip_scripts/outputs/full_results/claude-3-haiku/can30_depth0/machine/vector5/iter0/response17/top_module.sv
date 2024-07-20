module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
wire [24:0] not_a, not_b, not_c, not_d, not_e, result;

// Create 5-bit vectors from the input signals
assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

// Compute the complement of the 5-bit vectors
assign not_a = ~{a_bits};
assign not_b = ~{b_bits};
assign not_c = ~{c_bits};
assign not_d = ~{d_bits};
assign not_e = ~{e_bits};

// Compute the bitwise XOR of the two 25-bit vectors
assign result = not_a ^ not_b ^ not_c ^ not_d ^ not_e ^ {a_bits, b_bits, c_bits, d_bits, e_bits};

// Assign the result to the output
assign out = result;

endmodule
