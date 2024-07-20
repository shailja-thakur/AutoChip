module top_module (
	input [7:0] in,
	output [31:0] out
);
	assign out = { {24{1'b0}}, in };
endmodule
