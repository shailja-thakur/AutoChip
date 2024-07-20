module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	//Wire to hold the results of logical operations
	wire [0:0] and_result;
	wire [0:0] or_result;
	wire [0:0] xor_result;

	//AND operation
	assign and_result = &in;

	//OR operation
	assign or_result = |in;

  	//XOR operation
	assign xor_result = ^in;

	//Assigning results to output ports
	assign out_and = and_result[0];
	assign out_or = or_result[0];
	assign out_xor = xor_result[0];

endmodule
