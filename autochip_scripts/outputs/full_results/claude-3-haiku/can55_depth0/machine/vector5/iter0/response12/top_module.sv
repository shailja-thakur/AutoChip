module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] a_5, b_5, c_5, d_5, e_5;
    wire [24:0] inv_a_5, inv_b_5, inv_c_5, inv_d_5, inv_e_5, a_to_e;

    // Generate 5-bit vectors from input signals
    assign a_5 = {5{a}};
    assign b_5 = {5{b}};
    assign c_5 = {5{c}};
    assign d_5 = {5{d}};
    assign e_5 = {5{e}};

    // Invert the 5-bit vectors
    assign inv_a_5 = ~a_5;
    assign inv_b_5 = ~b_5;
    assign inv_c_5 = ~c_5;
    assign inv_d_5 = ~d_5;
    assign inv_e_5 = ~e_5;

    // Concatenate the inverted 5-bit vectors
    assign a_to_e = {inv_a_5, inv_b_5, inv_c_5, inv_d_5, inv_e_5};

    // Concatenate the 5-bit vectors
    assign out = a_to_e ^ {a_5, b_5, c_5, d_5, e_5};

endmodule
