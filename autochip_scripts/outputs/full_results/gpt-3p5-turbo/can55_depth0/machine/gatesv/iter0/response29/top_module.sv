module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Wire declarations
	wire [2:0] and_result;
	wire [3:1] or_result;
	wire [3:0] xor_result;

	// AND operation
	assign and_result = in[2:0] & in[3:1];

	// OR operation
	assign or_result = in[2:0] | in[3:1];

	// XOR operation
	assign out_different = {in[3:1], in[0]} ^ in;

	// Output assignments
	assign out_both = and_result;
	assign out_any = or_result;

endmodule
