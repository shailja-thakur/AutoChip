module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);
	always @(*) begin
		case (do_sub)
			1'b0: out = a + b;  // Perform addition
			1'b1: out = a - b;  // Perform subtraction
			default: out = 8'b0; // Default case to handle any unexpected values, should normally not occur
		endcase
		
		// Set result_is_zero flag
		if (out == 8'b0) 
			result_is_zero = 1;
		else 
			result_is_zero = 0;
	end
endmodule
