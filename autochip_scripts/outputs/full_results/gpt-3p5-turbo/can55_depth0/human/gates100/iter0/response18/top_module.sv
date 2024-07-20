module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

// AND gate implementation
wire [99:0] and_out;
assign out_and = and(and_out);

// OR gate implementation
wire [99:0] or_out;
assign out_or = or(or_out);

// XOR gate implementation
wire [99:0] xor_out;
assign out_xor = xor(xor_out);

// Gate connections
assign and_out = &in;
assign or_out = |in;
assign xor_out = ^in;

endmodule
