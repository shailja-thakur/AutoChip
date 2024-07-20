module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [3:0] temp;
assign temp = in;

assign out_and = &temp;
assign out_or = |temp;
assign out_xor = ^temp;

endmodule
