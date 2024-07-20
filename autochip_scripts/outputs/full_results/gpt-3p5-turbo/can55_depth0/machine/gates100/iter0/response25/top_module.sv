module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;

endmodule
