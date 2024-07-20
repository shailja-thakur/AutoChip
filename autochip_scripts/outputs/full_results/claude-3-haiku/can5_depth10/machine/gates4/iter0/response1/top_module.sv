module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform logical AND operation on all input bits
    assign out_and = &in;

    // Perform logical OR operation on all input bits
    assign out_or = |in;

    // Perform logical XOR operation on all input bits
    assign out_xor = ^in;

endmodule
