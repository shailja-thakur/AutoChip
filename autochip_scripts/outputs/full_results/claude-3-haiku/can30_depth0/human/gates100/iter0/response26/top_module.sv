module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] in_buf;

assign in_buf = in;

assign out_and = &in_buf;
assign out_or = |in_buf;
assign out_xor = ^in_buf;

endmodule
