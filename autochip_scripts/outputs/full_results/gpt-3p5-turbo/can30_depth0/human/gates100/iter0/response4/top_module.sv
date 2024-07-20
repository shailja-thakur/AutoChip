module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] and_input;
assign and_input = in;

wire [99:0] or_input;
assign or_input = in;

wire [99:0] xor_input;
assign xor_input = in;

assign out_and = and(and_input);
assign out_or = or(or_input);
assign out_xor = xor(xor_input);

endmodule
