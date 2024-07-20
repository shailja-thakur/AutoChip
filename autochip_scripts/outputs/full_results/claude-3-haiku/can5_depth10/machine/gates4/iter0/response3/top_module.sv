module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the outputs based on the logical operations
    assign out_and = &in;    // Logical AND
    assign out_or = |in;     // Logical OR
    assign out_xor = ^in;    // Logical XOR

endmodule
