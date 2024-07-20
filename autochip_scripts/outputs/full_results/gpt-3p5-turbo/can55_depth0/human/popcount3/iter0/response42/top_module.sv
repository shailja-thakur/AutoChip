module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Implementation of population count circuit

	// Intermediate variables
	wire [2:0] and_result;
	wire [1:0] or_result;

	// AND gates to check each bit
	and gate0 (.a(in[0]), .b(in[1]), .z(and_result[0]));
	and gate1 (.a(in[1]), .b(in[2]), .z(and_result[1]));

	// OR gate to combine AND gate results
	or gate2 (.a(and_result[0]), .b(and_result[1]), .z(or_result));

	// Output assignment
	assign out = or_result;

endmodule
