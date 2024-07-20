module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] inv_a, inv_b, inv_c, inv_d, inv_e;
    wire [24:0] a_vector, b_vector, c_vector, d_vector, e_vector;

    // Generate 25-bit vectors from input signals
    assign inv_a = {25{~a}};
    assign inv_b = {25{~b}};
    assign inv_c = {25{~c}};
    assign inv_d = {25{~d}};
    assign inv_e = {25{~e}};

    assign a_vector = {25{a}};
    assign b_vector = {25{b}};
    assign c_vector = {25{c}};
    assign d_vector = {25{d}};
    assign e_vector = {25{e}};

    // Compute the bitwise exclusive-or of the two 25-bit vectors
    assign out = inv_a ^ a_vector ^
                 inv_b ^ b_vector ^
                 inv_c ^ c_vector ^
                 inv_d ^ d_vector ^
                 inv_e ^ e_vector;

endmodule
