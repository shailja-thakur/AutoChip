module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_vec, b_vec, c_vec, d_vec, e_vec;
    wire [4:0] a_not, b_not, c_not, d_not, e_not;

    // Generate 5-bit vectors from the input signals
    assign a_vec = {5{a}};
    assign b_vec = {5{b}};
    assign c_vec = {5{c}};
    assign d_vec = {5{d}};
    assign e_vec = {5{e}};

    // Invert the 5-bit vectors
    assign a_not = ~a_vec;
    assign b_not = ~b_vec;
    assign c_not = ~c_vec;
    assign d_not = ~d_vec;
    assign e_not = ~e_vec;

    // Concatenate the inverted 5-bit vectors and the original 5-bit vectors
    assign out = {a_not, b_not, c_not, d_not, e_not} ^ {a_vec, b_vec, c_vec, d_vec, e_vec};

endmodule
