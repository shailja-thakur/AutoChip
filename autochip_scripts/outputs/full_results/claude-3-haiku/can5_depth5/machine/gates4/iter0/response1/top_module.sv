module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the outputs based on the logical operations on the 4-bit input
    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;

endmodule
