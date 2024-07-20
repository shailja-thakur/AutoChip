module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
    wire [24:0] vec1, vec2;

    // Generate the first 25-bit vector
    assign a_vec = {5{~a}};
    assign b_vec = {5{~b}};
    assign c_vec = {5{~c}};
    assign d_vec = {5{~d}};
    assign e_vec = {5{~e}};
    assign vec1 = {a_vec, b_vec, c_vec, d_vec, e_vec};

    // Generate the second 25-bit vector
    assign vec2 = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or
    assign out = vec1 ^ vec2;

endmodule
