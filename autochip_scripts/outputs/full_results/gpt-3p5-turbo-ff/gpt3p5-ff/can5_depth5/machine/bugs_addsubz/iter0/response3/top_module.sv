module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);
	always @(*) begin
		case (do_sub)
			0: out = a + b;  	// Addition operation
			1: out = a - b;  	// Subtraction operation
		endcase

		if (out == 0)
			result_is_zero = 1;   // Set result_is_zero to 1 if out is zero
		else
			result_is_zero = 0;   // Set result_is_zero to 0 if out is non-zero
	end
endmodule
