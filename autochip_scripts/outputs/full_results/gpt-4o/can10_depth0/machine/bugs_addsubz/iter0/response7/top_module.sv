module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		case (do_sub)
			1'b0: out = a + b;    // Perform addition when do_sub is 0
			1'b1: out = a - b;    // Perform subtraction when do_sub is 1
			default: out = 8'b0;  // Default case to handle unexpected values
		endcase
		
		// Set result_is_zero if the output is zero
		if (out == 8'd0)
			result_is_zero = 1;
		else
			result_is_zero = 0;
	end
	
endmodule
