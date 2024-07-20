module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		// Perform addition or subtraction based on do_sub
		if (do_sub == 1'b0) 
			out = a + b;    // Perform addition
		else 
			out = a - b;    // Perform subtraction

		// Check if the result is zero
		if (out == 8'b00000000)
			result_is_zero = 1'b1;
		else
			result_is_zero = 1'b0;
	end

endmodule
