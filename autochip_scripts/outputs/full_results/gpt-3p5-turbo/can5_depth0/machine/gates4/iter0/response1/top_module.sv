module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // Logic for out_and output
    assign out_and = &in;

    // Logic for out_or output
    assign out_or = |in;

    // Logic for out_xor output
    assign out_xor = ^in;

endmodule
