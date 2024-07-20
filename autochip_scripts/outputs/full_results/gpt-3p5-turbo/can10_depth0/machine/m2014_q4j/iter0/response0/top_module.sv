module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// There are no internal logic gates needed for this module
	assign sum = {1'b0, x} + {1'b0, y};
endmodule
