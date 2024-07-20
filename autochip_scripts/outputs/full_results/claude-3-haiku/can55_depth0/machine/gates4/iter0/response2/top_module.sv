module top_module (
    input  [3:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);

    // Assign the outputs based on the specified operations
    assign out_and = &in;
    assign out_or  = |in;
    assign out_xor = ^in;

endmodule
