module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);
	always @(do_sub or a or b) begin
		case (do_sub)
			1'b0: out = a + b;  // Perform addition if do_sub is 0
			1'b1: out = a - b;  // Perform subtraction if do_sub is 1
			default: out = 8'b0;  // Default to 0
		endcase
		result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0; // Set result_is_zero based on the result
	end
endmodule
