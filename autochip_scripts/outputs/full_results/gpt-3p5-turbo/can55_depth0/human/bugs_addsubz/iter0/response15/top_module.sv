module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		case (do_sub)
			0: out = a+b;
			1: out = a-b;
		endcase

		if (out == 0) // Compare with zero using the equality operator "=="
			result_is_zero = 1;
		else
			result_is_zero = 0; // Add an else case to set the flag to 0 if not equal to zero
	end

endmodule
