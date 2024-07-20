module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform bitwise AND operation on all input bits
    assign out_and = &in;

    // Perform bitwise OR operation on all input bits
    assign out_or = |in;

    // Perform bitwise XOR operation on all input bits
    assign out_xor = ^in;

endmodule
