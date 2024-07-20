module top_module (
	input [7:0] in,
	output parity
);

	assign parity = ^in; // using Verilog reduction operator to perform XOR on all bits of 'in'

endmodule
