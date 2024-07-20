module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform the AND operation
    assign out_and = &in;

    // Perform the OR operation
    assign out_or = |in;

    // Perform the XOR operation
    assign out_xor = ^in;

endmodule
