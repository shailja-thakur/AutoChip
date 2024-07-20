module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	// 100-input AND gate
	wire wire_and;
	and #(100) and_gate(.a(in), .out(wire_and));
	assign out_and = wire_and;
	
	// 100-input OR gate
	wire wire_or;
	or #(100) or_gate(.a(in), .out(wire_or));
	assign out_or = wire_or;
	
	// 100-input XOR gate
	wire wire_xor;
	xor #(100) xor_gate(.a(in), .out(wire_xor));
	assign out_xor = wire_xor;

endmodule
