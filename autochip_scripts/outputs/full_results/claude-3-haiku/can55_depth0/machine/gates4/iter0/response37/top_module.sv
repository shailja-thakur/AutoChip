module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Assign the results of the logical operations to the outputs
    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;

endmodule
