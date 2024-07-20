module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	//wire declarations
	wire [99:0] and_bits;
	wire [99:0] or_bits;
	wire [99:0] xor_bits;
	
	//AND operation
	assign out_and = and_bits[99];
	assign and_bits = &in;
	
	//OR operation
	assign out_or = or_bits[99];
	assign or_bits = |in;
	
	//XOR operation
	assign out_xor = xor_bits[99];
	assign xor_bits = ^in;
 
endmodule
