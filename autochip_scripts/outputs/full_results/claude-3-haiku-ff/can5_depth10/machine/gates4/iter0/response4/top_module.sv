module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform the logical AND operation on all bits of 'in'
    assign out_and = &in;

    // Perform the logical OR operation on all bits of 'in'
    assign out_or = |in;

    // Perform the logical XOR operation on all bits of 'in'
    assign out_xor = ^in;

endmodule
