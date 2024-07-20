module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the out_and output to the result of a logical AND operation on all of the bits in the in[3:0] inputs
    assign out_and = &in;

    // Assign the out_or output to the result of a logical OR operation on all of the bits in the in[3:0] inputs
    assign out_or = |in;

    // Assign the out_xor output to the result of a logical XOR operation on all of the bits in the in[3:0] inputs
    assign out_xor = ^in;

endmodule
