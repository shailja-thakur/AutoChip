module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_bits, b_bits, c_bits, d_bits, e_bits;
wire [24:0] not_a_bits, not_b_bits, not_c_bits, not_d_bits, not_e_bits;
wire [24:0] combined_bits;

// Generate 5-bit vectors from the input signals
assign a_bits = {5{a}};
assign b_bits = {5{b}};
assign c_bits = {5{c}};
assign d_bits = {5{d}};
assign e_bits = {5{e}};

// Invert the 5-bit vectors
assign not_a_bits = ~{a_bits};
assign not_b_bits = ~{b_bits};
assign not_c_bits = ~{c_bits};
assign not_d_bits = ~{d_bits};
assign not_e_bits = ~{e_bits};

// Concatenate the inverted 5-bit vectors
assign combined_bits = {not_a_bits, not_b_bits, not_c_bits, not_d_bits, not_e_bits};

// Compute the bitwise exclusive-or
assign out = combined_bits ^ {5{a,b,c,d,e}};

endmodule
