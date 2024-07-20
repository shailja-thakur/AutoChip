module top_module (
	input wire in1,
	input wire in2,
	output wire out
);

	assign out = ~(in1 | in2);

endmodule
