module top_module(
    input x,
    input y,
    output z);

    // logic for generating the output z
    wire xor_output;
    assign xor_output = x ^ y;
    assign z = xor_output & x;

endmodule
