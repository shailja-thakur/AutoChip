module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		// Perform the operation based on do_sub input
		case (do_sub)
			1'b0: out = a + b;  // Addition
			1'b1: out = a - b;  // Subtraction
			// Default case to cover potential X state for do_sub
			default: out = 8'b00000000;
		endcase

		// Set result_is_zero based on the result of the operation
		if (out == 8'b00000000)
			result_is_zero = 1;
		else
			result_is_zero = 0;
	end

endmodule
