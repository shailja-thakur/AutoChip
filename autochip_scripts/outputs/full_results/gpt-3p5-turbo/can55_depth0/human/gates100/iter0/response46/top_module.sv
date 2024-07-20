module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

wire [99:0] in_and;        // wire for AND gate input
wire [99:0] in_or;         // wire for OR gate input
wire [99:0] in_xor;        // wire for XOR gate input

assign in_and = &in;       // perform AND operation on input
assign in_or = |in;        // perform OR operation on input
assign in_xor = ^in;       // perform XOR operation on input

assign out_and = in_and[99];     // assign the output of AND gate
assign out_or = in_or[99];       // assign the output of OR gate
assign out_xor = in_xor[99];     // assign the output of XOR gate

endmodule
