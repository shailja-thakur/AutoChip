module top_module(
	input [1:0] A,
	input [1:0] B,
	output reg z);

	// Initialization
	always @(A or B) begin
		z = 1;
	end

	// Comparison Logic
	always @(A or B) begin
		if (A != B)
			z = 0;
	end

endmodule
