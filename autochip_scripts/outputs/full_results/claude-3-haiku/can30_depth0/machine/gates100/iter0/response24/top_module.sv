module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform the logical AND operation
    assign out_and = &in;

    // Perform the logical OR operation
    assign out_or = |in;

    // Perform the logical XOR operation
    assign out_xor = ^in;

endmodule
