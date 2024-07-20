module top_module (
	input wire in1,
	input wire in2,
	input wire in3,
	output wire out
);

	assign out = (~(in1 ^ in2)) ^ in3;

endmodule
