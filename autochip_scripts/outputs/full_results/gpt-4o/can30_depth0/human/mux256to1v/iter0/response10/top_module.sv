module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Select the 4-bit segment of 'in' based on 'sel' value
	assign out = in[(sel * 4) +: 4];

endmodule
