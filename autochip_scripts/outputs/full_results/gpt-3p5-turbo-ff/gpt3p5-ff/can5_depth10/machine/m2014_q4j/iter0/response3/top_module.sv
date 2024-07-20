module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Adder logic
	assign sum = x + y;
endmodule
